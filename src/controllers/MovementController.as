package controllers 
{
	import com.uselessworks.Vector2;
	import data.Balance;
	import entities.Unit;
	import level.Tile;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class MovementController 
	{
		private static var _unit:Unit;
		private static var _startTime:int;
		private static var _movement:int;
		private static var _path:Vector.<Tile>;
		
		public static function init():void {
			
		}
		
		public static function startMovement(unit:Unit):void {
			_unit = unit;
			_startTime = Game.time;
			_movement = Balance.TIME_RANGE - _startTime;
			
			_path = new Vector.<Tile>;
			_path.push(Game.getTileAt(_unit.x, _unit.y));
			
			CursorController.overrideCanMove(_canMove);
			
			Events.onCursorMove.add(_onCursorMove);
			Events.onRender.add(_drawPath);
			
			Game.changeState("move");
		}
		
		private static function _canMove(x:int, y:int):Boolean {
			var can:Boolean = false;
			
			var tile:Tile = Game.getTileAt(x, y);
			var tileIndex:int = _path.lastIndexOf(tile);
			if (tile) {
				if ( tileIndex >= 0 && tileIndex == _path.length - 2) {
					can = true;
				} else {
					trace(_movement, tile.movementCost);
					if (tile.movementCost <= _movement) {
						if (!Game.getUnitAt(x, y, Game.time + tile.movementCost)) {
							can = true;
						}
					}
				}
			}
			return can;
		}
		
		public static function cancelMovement():void {
			Events.onCursorMove.remove(_onCursorMove);
			Events.onRender.remove(_drawPath);
			CursorController.clearCanMove();
			
			Game.setTime(_startTime);
		}
		
		private static function _onCursorMove(from:Tile, to:Tile):void {
			var tile:Tile = Game.getTileAt(to.x, to.y);
			var tileIndex:int = _path.lastIndexOf(tile);
			if ( tileIndex >= 0 && tileIndex == _path.length - 2) {
				_path.pop();
				var movementCost:int = Game.getTileAt(from.x, from.y).movementCost
				_movement += movementCost;
				Game.setTime(Game.time - movementCost);
			} else {
				_path.push(tile);
				_movement -= tile.movementCost;
				Game.setTime(Game.time + tile.movementCost);
			}
			//trace(_movement);
		}
		
		private static function _drawPath():void {
			for each (var t:Tile in _path) {
				t.draw(0x0000FF, 0.5);
			}
		}
		
		public static function applyMovement():void {
			_unit.applyPath(_path, _startTime);
			
			Events.onCursorMove.remove(_onCursorMove);
			Events.onRender.remove(_drawPath);
			CursorController.clearCanMove();
			
			Game.changeState("idle");
		}
		
	}

}