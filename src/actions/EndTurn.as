package actions 
{
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class EndTurn extends Action 
	{
		public function EndTurn() {
			_name = "End turn";
			_cost = 0;
		}
		
		override public function execute():void {
			trace("end turn");
		}
	}

}