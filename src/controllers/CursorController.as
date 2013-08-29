package controllers 
{
	import com.uselessworks.Vector2;
	import entities.Cursor;
	/**
	 * ...
	 * @author ...
	 */
	public class CursorController 
	{
		private static var _cursor:Cursor;
		private static var _canMoveFunction:Function;
		
		public static function init():void {	
			Game.level.add(_cursor = new Cursor);
			Game.cursor = _cursor;
			
			Events.onKeyUpPressed.add(function():void {
				if (_canMoveTo(_cursor.x, _cursor.y - 1)) {
					_cursor.moveUp();
				} else {
					Events.onCursorInvalidMove.dispatch();
				}
			});
			
			Events.onKeyRightPressed.add(function():void {
				if (_canMoveTo(_cursor.x + 1, _cursor.y)) {
					_cursor.moveRight();
				} else {
					Events.onCursorInvalidMove.dispatch();
				}
			});
			
			Events.onKeyDownPressed.add(function():void {
				if (_canMoveTo(_cursor.x, _cursor.y + 1)) {
					_cursor.moveDown();
				} else {
					Events.onCursorInvalidMove.dispatch();
				}
			});
			
			Events.onKeyLeftPressed.add(function():void {
				if (_canMoveTo(_cursor.x - 1, _cursor.y)) {
					_cursor.moveLeft();
				} else {
					Events.onCursorInvalidMove.dispatch();
				}
			});
		}
		
		public static function overrideCanMove(f:Function):void {
			_canMoveFunction = f;
		}
		
		public static function clearCanMove():void {
			_canMoveFunction = null;
		}
		
		private static function _canMoveTo(x:int, y:int):Boolean {
			var can:Boolean = false;
			if (MapController.getTileAt(x, y)) {
				can = _canMoveFunction != null ? _canMoveFunction(x,y) : true;
			}
			return can;
		}
		
	}

}