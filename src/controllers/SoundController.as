package controllers 
{
	import com.uselessworks.Vector2;
	import data.Assets;
	import net.flashpunk.Sfx
	import level.Tile;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class SoundController 
	{
		private static var _bumpSfx:Sfx = new Sfx(Assets.SFX_BUMP);
		private static var _blipSfx:Sfx = new Sfx(Assets.SFX_BLIP);
		
		public static function init():void
		{
			Events.onCursorMove.add(function(from:Tile, to:Tile):void {
				_blip();
			});
			Events.onCursorInvalidMove.add(_bump);
		}
		
		private static function _bump():void { _bumpSfx.play(); }
		private static function _blip():void { _blipSfx.play(); }
		
	}

}