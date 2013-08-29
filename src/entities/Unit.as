package entities
{
	import actions.unit.Move;
	import actions.Action;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import data.Assets;
	import data.Balance;
	import level.Tile;
	
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Unit extends TileEntity 
	{
		private var _MaxMovementPoints:int;
		public function get movement():int { return _MaxMovementPoints - Game.time }
		
		public var selected:Boolean = false;
		
		private var _positions:Vector.<Tile>;
		protected var _actions:Vector.<Class> = new Vector.<Class>;
		public function get actions():Vector.<Class> { return _actions }
		
		public function Unit(x:int = 0, y:int = 0) 
		{
			super(x, y);
			_MaxMovementPoints = Game.maxTime;
			
			//graphic = Image.createRect(Game.tileWidth, Game.tileHeight, 0xFF0000);
			graphic = new Image(Assets.IMG_Unit);
		}
		
		override public function added():void {
			var _this:Unit = this;
			reset();
			_setActions();
			Events.onUnitAdded.dispatch(this);
			Events.onTimeChange.add(function(from:int, to:int):void {
				_updatePosition();
			});
			Events.onUnitMoved.add(function(unit:Unit):void {
				if (unit == _this) { 
					_updatePosition();
				}
			});
		}
		
		private function _updatePosition():void {
			var position:Tile = getPositionAt(Game.time);
			x = position.x;
			y = position.y;
		}
		
		protected function _setActions():void {
			_actions.push(Move);
		}
		
		public function reset():void {			
			_positions = new Vector.<Tile>(_MaxMovementPoints + 1);
			_positions[0] = Game.getTileAt(x,y);
			
			clearPositionsAfter(0);
			
			selected = false;
		}
		
		public function clearPositionsAfter(time:int):void {
			for (var t:int = time + 1; t < _positions.length; t++) {
				_positions[t] = null;
			}
		}
		
		public function setPositionAt(time:int, x:int, y:int):void {
			
			var from:Tile = getPositionAt(time);
			var to:Tile = Game.getTileAt(x, y);
			
			_positions[time] = to;
			clearPositionsAfter(time);
			
			Events.onUnitMoved.dispatch(time, this, from, to);
		}
		
		public function getPositionAt(time:int):Tile {
			var position:Tile;
			while (!position && time >= 0) {
				position = _positions[time];
				time--;
			}
			return position;
		}
		
		public function getMovementAt(time:int):int {
			return _MaxMovementPoints - time
		}
		
		
		public function select():void {
			selected = true;
			(graphic as Image).color = 0xFF0000;
			
			Events.onUnitSelected.dispatch(this);
		}
		
		public function deselect():void {
			selected = false;
			(graphic as Image).color = 0xFFFFFF;
			
			Events.onUnitDeselected.dispatch(this);
		}
		
		public function applyPath(path:Vector.<Tile>, startTime:int):void {
			for (var time:int = startTime; time < startTime + path.length; time++) {
				_positions[time] = path[time - startTime];
			}
			clearPositionsAfter(time);
			Events.onUnitMoved.dispatch(this);
		}
	}

}