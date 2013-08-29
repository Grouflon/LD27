package controllers 
{
	import com.uselessworks.Vector2;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import data.Balance;
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class InputController 
	{
		private static var _debugKey:int = Key.F2;
		private static var _consoleKey:int = Key.F1;
		
		private static var _cursorPosition:Vector2 = new Vector2;
		public static function get cursorPosition():Vector2 { return _cursorPosition }
		
		public static function update():void {
			// KEYBOARD INPUT
			if (_anyKeyPressed(Balance.GRID_KEYS)) { Events.onGridDebugKeyPressed.dispatch(); }
			if (_anyKeyPressed(Balance.CONSOLE_KEYS)) {	Events.onConsoleDebugKeyPressed.dispatch();	}
			
			if (_anyKeyPressed(Balance.UP_KEYS)) { Events.onKeyUpPressed.dispatch(); }
			if (_anyKeyPressed(Balance.RIGHT_KEYS)) { Events.onKeyRightPressed.dispatch(); }
			if (_anyKeyPressed(Balance.DOWN_KEYS)) { Events.onKeyDownPressed.dispatch(); }
			if (_anyKeyPressed(Balance.LEFT_KEYS)) { Events.onKeyLeftPressed.dispatch(); }
			
			if (_anyKeyPressed(Balance.ACTION_KEYS)) { Events.onActionKeyPressed.dispatch(); }
			if (_anyKeyPressed(Balance.RETURN_KEYS)) { Events.onReturnKeyPressed.dispatch(); }
			if (_anyKeyPressed(Balance.TIMEUP_KEYS)) { Events.onTimeUpKeyPressed.dispatch(); }
			if (_anyKeyPressed(Balance.TIMEDOWN_KEYS)) { Events.onTimeDownKeyPressed.dispatch(); }
			
			// MOUSE INPUT
			if (Input.mousePressed) { Events.onMousePressed.dispatch();	}
			if (Input.mousePressedRight) { Events.onMousePressedRight.dispatch(); }
			
			/*var currentCursorPosition:Vector2 = Game.level.globalToTileCoordinates(Game.level.mouseX, Game.level.mouseY);
			if (_cursorPosition.toString() != currentCursorPosition.toString()) {
				_cursorPosition = currentCursorPosition;
				Events.onMouseMoved.dispatch();
			}*/
		}
		
		private static function _anyKeyPressed(keys:Array):Boolean {
			var pressed:Boolean = false;
			for each (var key:int in keys) {
				pressed = pressed || Input.pressed(key);
			}
			return pressed;
		}
		
		private static function _anyKeyDown(keys:Array):Boolean {
			var pressed:Boolean = false;
			for each (var key:int in keys) {
				pressed = pressed || Input.check(key);
			}
			return pressed;
		}
		
		private static function _anyKeyReleased(keys:Array):Boolean {
			var pressed:Boolean = false;
			for each (var key:int in keys) {
				pressed = pressed || Input.released(key);
			}
			return pressed;
		}
		
	}

}