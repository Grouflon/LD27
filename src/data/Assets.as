package data
{
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Assets 
	{
		// LEVELS
		[Embed(source = "../assets/levels/testLevel.tmx", mimeType = "application/octet-stream")] public static const XML_TESTLVL:Class;
		[Embed(source = '../assets/tempTileset.png')] public static const TILESET:Class;
		
		// ENTITIES
		[Embed(source = '../assets/entitiesTileset.png')] public static const IMG_Unit:Class;
		
		// SOUNDS
		[Embed(source="../assets/sounds/sounds.swf", symbol="bump")] public static const SFX_BUMP:Class;
		[Embed(source="../assets/sounds/sounds.swf", symbol="blip")] public static const SFX_BLIP:Class;
	}

}