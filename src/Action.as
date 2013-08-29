package  
{
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Action 
	{
		private var _name:String;
		public function get name():String { return _name }
		
		private var _cost:int;
		public function get cost():int { return _cost }
		
		private var _action:Function;
		private var _condition:Function;
		
		public function Action(name:String, cost:int, action:Function, condition:Function)
		{
			_name = name;
			_cost = cost;
			_action = action;
			_condition = condition;
		}
		
	}

}