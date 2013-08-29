package actions.unit 
{
	import controllers.MovementController;
	import data.Strings;
	import entities.Unit;
	import actions.Action;
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class Move extends Action 
	{
		public static var name:String = Strings.MOVE_ACTION;
		
		public function Move(time:int, unit:Unit, x:int, y:int) 
		{
			_duration = 0;
			super(time, unit, x, y);
		}
		
		override public function execute():void {
			/*_owner.select();
			MovementController.startMovement(_owner);*/
			
			trace('move');
		}
		
		public static function condition():Boolean {
			return Game.time < Game.maxTime;
		}
	}
}