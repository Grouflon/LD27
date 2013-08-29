package pathfinding 
{
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Node 
	{
		private var _x:int;
		private var _y:int;
		public function get x():int { return _x }
		public function get y():int { return _y }
		
		private var _cost:Number;
		public function get cost():Number { return _cost }
		
		public var parent:Node = null;
		public var g:Number = 0;
		public var h:Number = 0;
		public function get f():Number { return g + h }
		
		public function Node(x:int, y:int, cost:Number = 1) 
		{
			_x = x;
			_y = y;
			_cost = cost;
		}
	}
}