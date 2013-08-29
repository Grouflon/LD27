package  
{
	import org.osflash.signals.Signal;
	import entities.Unit;
	import com.uselessworks.Vector2;
	import level.Tile;
	import level.TileWorld;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Events 
	{
		public static var onGridDebugKeyPressed:Signal = new Signal();
		public static var onConsoleDebugKeyPressed:Signal = new Signal();
		public static var onRender:Signal = new Signal();
		
		public static var onUnitAdded:Signal = new Signal(Unit);
		public static var onUnitMoved:Signal = new Signal(Unit/*int, Unit, Tile, Tile*/);
		public static var onUnitSelected:Signal = new Signal(Unit);
		public static var onUnitDeselected:Signal = new Signal(Unit);
		
		public static var onLevelStart:Signal = new Signal(TileWorld);
		public static var onStateChange:Signal = new Signal(String, String);
		public static var onTimeChange:Signal = new Signal(int, int);
		public static var onActionTriggered:Signal = new Signal(Class);
		
		public static var onContextMenuOpen:Signal = new Signal();
		public static var onContextMenuClose:Signal = new Signal();
		
		public static var onCursorMove:Signal = new Signal(Tile, Tile);
		public static var onCursorInvalidMove:Signal = new Signal();
		
		// INPUT
		public static var onMousePressed:Signal = new Signal();
		public static var onMousePressedRight:Signal = new Signal();
		public static var onMouseMoved:Signal = new Signal();
		public static var onKeyUpPressed:Signal = new Signal();
		public static var onKeyRightPressed:Signal = new Signal();
		public static var onKeyDownPressed:Signal = new Signal();
		public static var onKeyLeftPressed:Signal = new Signal();
		public static var onActionKeyPressed:Signal = new Signal();
		public static var onReturnKeyPressed:Signal = new Signal();
		public static var onTimeUpKeyPressed:Signal = new Signal();
		public static var onTimeDownKeyPressed:Signal = new Signal();
	}

}