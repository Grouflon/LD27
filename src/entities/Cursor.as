package entities
{
	import controllers.MapController;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import level.Tile;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Cursor extends TileEntity 
	{
		public var canMove:Boolean = true;
		
		public function Cursor() 
		{
			var bmd:BitmapData = new BitmapData(Game.tileWidth, Game.tileHeight, true, 0x00000000);
			Draw.setTarget(bmd);
			Draw.rectPlus(0, 0, Game.tileWidth, Game.tileHeight, 0xFFFFFF, 1.0, false, 4);
			Draw.resetTarget();
			graphic = new Image(bmd);
		}
		
		public function getUnit():Unit {
			
			return MapController.getUnitAt(x, y, Game.time);
		}
		
		public function getTile():Tile {
			return MapController.getTileAt(x, y);
		}
		
		override public function moveUp():void {
			if (canMove) {
				var from:Tile = getTile();
				super.moveUp();
				var to:Tile = getTile();
				Events.onCursorMove.dispatch(from, to);
			}
		}
		
		override public function moveRight():void {
			if (canMove) {
				var from:Tile = getTile();
				super.moveRight();
				var to:Tile = getTile();
				Events.onCursorMove.dispatch(from, to);
			}
		}
		
		override public function moveDown():void {
			if (canMove) {
				var from:Tile = getTile();
				super.moveDown();
				var to:Tile = getTile();
				Events.onCursorMove.dispatch(from, to);
			}
		}
		
		override public function moveLeft():void {
			if (canMove) {
				var from:Tile = getTile();
				super.moveLeft();
				var to:Tile = getTile();
				Events.onCursorMove.dispatch(from, to);
			}
		}
	}

}