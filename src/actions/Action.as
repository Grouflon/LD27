package actions
{
	import entities.Unit;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Action 
	{	
		protected var _duration:int;
		protected var _startTime:int;
		protected var _unit:Unit;;
		protected var _x:int;
		protected var _y:int;
		
		public function get startTime():int { return _startTime }
		public function get endTime():int { return _startTime + _duration }
		public function get duration():int { return _duration }
		public function get unit():Unit { return _unit }
		public function get x():int { return _x }
		public function get y():int { return _y }
		
		public function Action( time:int, unit:Unit = null, x:int = 0, y:int = 0 )
		{
			_startTime = time;
			_unit = unit;
			_x = x;
			_y = y;
		}
		
		public function execute():void {
			
		}
		
		public static function condition():Boolean {
			return true;
		}
		
	}

}