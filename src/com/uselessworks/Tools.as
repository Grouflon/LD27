package com.uselessworks
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	public class Tools 
	{
		
		
		public static function degreesToRadians(angle:Number):Number {
			angle = angle * Math.PI / 180; 
			return(angle);
		}
		
		public static function radiansToDegrees(angle:Number):Number {
			angle = angle * 180 / Math.PI;
			return(angle);
		}
		
		public static function randRange(start:Number, end:Number) : Number  
		{  
		   return Math.floor(start +(Math.random() * (end - start)));  
		}
		
		public static function pythagore(side1:Number, side2:Number):Number
		{
			return Math.sqrt(Math.pow(side1, 2) + Math.pow(side2, 2));
		}
		
		public static function pick(a:Object):*
		{
			var i:int;
			var pick:*;
			
			if (a is Array || a is Vector)
			{
				var aa:Array = (a as Array);
				i = Tools.randRange(0, aa.length - 1);
				pick = aa[i];
			}
			
			if (a is Vector.<*>)
			{
				var va:Vector.<*> = (a as Vector.<*>);
				i = Tools.randRange(0, va.length - 1);
				pick = va[i];
			}
			
			return pick;
		}
		
		public static function pointIsInTriangle(point:Point, t1:Point, t2:Point, t3:Point):Boolean
		{
			/*
			//unit vectors
			var v0:Vector2 = new Vector2(o.left - o.centerX, o.top - o.centerY);
			var v1:Vector2 = new Vector2(o.right - o.centerX, o.top - o.centerY);
			var v2:Vector2 = new Vector2(x - o.centerX, y - o.centerY);
			
			// Compute dot products
			var dot00:Number = Vector2.dot(v0, v0)
			var dot01:Number = Vector2.dot(v0, v1)
			var dot02:Number = Vector2.dot(v0, v2)
			var dot11:Number = Vector2.dot(v1, v1)
			var dot12:Number = Vector2.dot(v1, v2)
			
			// Compute barycentric coordinates
			var invDenom:Number = 1 / (dot00 * dot11 - dot01 * dot01)
			var u:Number = (dot11 * dot02 - dot01 * dot12) * invDenom
			var v:Number = (dot00 * dot12 - dot01 * dot02) * invDenom
			
			trace('u = ' + u + '; v = ' + v);
			
			var collisionNormal:Vector2
			if (u > 0)
			{
				if (v > 0)
				{
					collisionNormal = Vector2.UP;
				} else {
					collisionNormal = Vector2.LEFT;
				}
			} else {
				if (v > 0)
				{
					collisionNormal = Vector2.RIGHT;
				} else {
					collisionNormal = Vector2.DOWN;
				}
			}*/
			return true;
		}
		
		
	}

}