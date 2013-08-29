package  
{
	import com.uselessworks.Vector2;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Tile 
	{
		private var _x:int;
		private var _y:int;
		public function get x():int { return _x }
		public function get y():int { return _x }
		
		/*private var _entities:Vector.<Vector.<Unit>> = new Vector.<Vector.<Unit>>
		public function get entities():Unit { return entities }*/
		
		private var _movementCost:int = 1;
		public function get movementCost():int { return _movementCost }
		
		public function Tile(x:int, y:int, movementCost:int) 
		{
			_x = x;
			_y = y;
			_movementCost = movementCost;
			
			/*Events.onUnitMoved.add(function(entity:Unit, moveStart:Vector2, moveEnd:Vector2, time:int) {
				if (moveStart.x == _x && moveStart.y == _y) {
					removeEntity(entity, time);
				}
				
				if (moveEnd.x == _x && moveEnd.y == _y) {
					addEntity(entity, time);
				}
			});*/
		}
		
		/*public function addEntity(entity:Unit, time:int):void {
			if (_entities[time].indexOf(entity) >= 0) {
				_entities[time].push(entity);
			}
		}
		
		public function removeEntity(entity:Unit, time:int):void {
			_entities[time].splice(_entities.indexOf(entity), 1);
		}*/
		
		public function draw(color:uint = 0xFFFFFF):void {
			Draw.rectPlus(_x * Game.tileWidth, _y * Game.tileHeight, Game.tileWidth, Game.tileHeight, color, 0.2, false);
			Draw.text(_movementCost.toString(), _x * Game.tileWidth + 1, _y * Game.tileHeight, {"color" : color});
		}
	}

}