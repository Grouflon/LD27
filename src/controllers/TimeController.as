package controllers 
{
	import actions.Action;
	import data.Balance;
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class TimeController 
	{
		private static var _time:int;
		public static function get time():int { return _time }
		
		private static var _maxTime:int;
		
		private static var _actions:Vector.<Action>;
		
		public static function init():void {
			_time = 0;
			_maxTime = Balance.TIME_RANGE;
			_actions = new Vector.<Action>;
		}
		
		public static function addAction(time:int, action:Action):void {
			_actions[time]
		}
		
		public static function setTime(time:int):void {
			if (time >= 0 && time <= _maxTime) {
				var currentTime:int = _time;
				_time = time;
				Events.onTimeChange.dispatch(currentTime, time);
			}
		}
		
		public static function timeUp():void {
			setTime(_time + 1);
		}
		
		public static function timeDown():void {
			setTime(_time - 1);
		}
	}
}