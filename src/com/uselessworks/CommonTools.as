package com.uselessworks 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class CommonTools 
	{
		public static function parseXML(data:Class):XML {
			var rawData:ByteArray = new data;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xml:XML = new XML(dataString);
			
			return xml;
		}
	}

}