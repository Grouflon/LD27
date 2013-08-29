package data 
{
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Balance 
	{
		// CONTROLS
		public static const CONSOLE_KEYS:Array = [Key.F1];
		public static const GRID_KEYS:Array = [Key.F2];
		
		public static const UP_KEYS:Array = [Key.UP, Key.Z];
		public static const RIGHT_KEYS:Array = [Key.RIGHT, Key.D];
		public static const DOWN_KEYS:Array = [Key.DOWN, Key.S];
		public static const LEFT_KEYS:Array = [Key.LEFT, Key.Q];
		
		public static const ACTION_KEYS:Array = [Key.W, Key.ENTER];
		public static const RETURN_KEYS:Array = [Key.X, Key.ESCAPE];
		public static const TIMEUP_KEYS:Array = [Key.NUMPAD_ADD];
		public static const TIMEDOWN_KEYS:Array = [Key.NUMPAD_SUBTRACT];
		
		// BALANCE
		public static const TIME_RANGE:int = 10;
	}
}