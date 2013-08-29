package level
{
	import actions.Action;
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
		public function get y():int { return _y }
		
		private var _movementCost:int = 1;
		public function get movementCost():int { return _movementCost }
		
		//protected var _actions:Vector.<Action> = new Vector.<Action>;
		//public function get actions():Vector.<Action> { return _actions }
		
		public function Tile(x:int, y:int, movementCost:int) 
		{
			_x = x;
			_y = y;
			_movementCost = movementCost;
			
			//_setActions();
		}
		
		//protected function _setActions():void {
		//}
		
		public function draw(color:uint = 0xFFFFFF, alpha:Number = 1.0 ):void {
			Draw.rectPlus(_x * Game.tileWidth, _y * Game.tileHeight, Game.tileWidth, Game.tileHeight, color, alpha, false);
			Draw.text(_movementCost.toString(), _x * Game.tileWidth + 1, _y * Game.tileHeight, {"color" : color});
		}
	}
}