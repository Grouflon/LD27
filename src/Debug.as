package  
{
	import controllers.MapController;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import level.Tile;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Debug 
	{
		public static var grid:Boolean = false;
		public static function get console():Boolean { return FP.console.visible }
		public static function set console(value:Boolean):void { FP.console.visible = value }
		
		public static function init():void {
			FP.console.enable();
			
			Events.onGridDebugKeyPressed.add(toggleGrid);
			Events.onConsoleDebugKeyPressed.add(toggleConsole);
			
			Events.onRender.add(_onRender);
			
			Events.onCursorMove.add(function(from:Tile, to:Tile):void {
				
			});
		}
		
		private static function _onRender():void {
			if (grid) {
				for each (var v:Vector.<Tile> in MapController.map) {
					for each (var t:Tile in v) {
						t.draw(0x000000, 0.2);
					}
				}
			}
		}
		
		public static function toggleConsole():void {
			console = !console
		}
		
		public static function toggleGrid():void {
			grid = !grid;
		}
		
		public static function drawTile(x:int, y:int, color:uint = 0xFFFFFF, alpha:Number = 1.0):void {
			Draw.rect(x * Game.tileWidth, y * Game.tileHeight, Game.tileWidth, Game.tileHeight, color, alpha);
		}
		
	}

}