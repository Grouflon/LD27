package com.uselessworks
{
	import flash.geom.Point;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	
	 /**
	 * 2 Dimensional Vector class.
	 */
	public class Vector2 extends Object
	{
		/**
		 * x Component of the Vector.
		 */
		private var _x:Number = 0;
		public function get x():Number { return _x }
		public function set x(value:Number):void { _x = p.x = value }
		/**
		 * y Component of the Vector.
		 */
		private var _y:Number = 0;
		public function get y():Number { return _y }
		public function set y(value:Number):void { _y = p.y = value }
		/**
		 * [Read-only] Point equivalent of the Vector2.
		 */
		public function get p():Point { return new Point(_x, _y) }
		/**
		 * Direction of the Vector in Radians.
		 */
		public function get directionR():Number 
		{
			var angle:Number = Math.acos(normalized.x);
			if (normalized.y < 0) 
			{
				angle += 2*(Math.PI - angle);
			}
			return angle;
		}
		/**
		 * Direction of the Vector in Degrees.
		 */
		public function get directionD():Number { return directionR * 180 / Math.PI; }
		/**
		 * Magnitude of the Vector.
		 */
		public function get magnitude():Number { return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)) }
		public function set magnitude(value:Number):void { this.normalize().multiply(value) }
		/**
		 * [Read-only] Squared Magnitude of the Vector.
		 */
		public function get magnitude2():Number { return (Math.pow(x, 2) + Math.pow(y, 2)) }
		/**
		 * [Read-only] Normalized Vector.
		 */
		public function get normalized():Vector2 { 
			if (magnitude != 0)
			{
				return new Vector2(x / magnitude, y / magnitude); 
			} else {
				return new Vector2; 
			}
		}
		/**
		 * [Read-only] Left perpendicular Vector.
		 */
		public function get perpendicularLeft():Vector2 { return new Vector2(y, -x); }
		/**
		 * [Read-only] Right perpendicular Vector.
		 */
		public function get perpendicularRight():Vector2 { return new Vector2(-y, x); }
		/**
		 * [Read-only] Opposite Vector.
		 */
		public function get opposite():Vector2 { return new Vector2( -x, -y); }
		
		public static const RIGHT:Vector2 = new Vector2(1, 0);
		public static const LEFT:Vector2 = new Vector2(-1, 0);
		public static const UP:Vector2 = new Vector2(0, -1);
		public static const DOWN:Vector2 = new Vector2(0, 1);
		
		/**
		 * Constructor. Can be used to assign Vector Components.
		 * @param	x			X position to place the Entity.
		 * @param	y			Y position to place the Entity.
		 */
		public function Vector2(x:Number = 0, y:Number = 0):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function toString():String
		{
			return '( ' + x + ', ' + y + ' )';
		}
		
		/**
		 * Adds a Vector to the current one.
		 * @param	v			Vector to add.
		 * @return	a reference to this Vector.
		 */
		public function add(v:Vector2):Vector2 
		{
			x += v.x;
			y += v.y;
			return this;
		}
		
		/**
		 * Returns the sum of 2 Vectors.
		 * @param	v1			Base Vector.
		 * @param	v2			Vector to add.
		 * @return	The sum of the 2 Vectors.
		 */
		public static function add(v1:Vector2, v2:Vector2):Vector2
		{
			return new Vector2(v1.x + v2.x, v1.y + v2.y);
		}
		
		/**
		 * Substract a Vector to the current one.
		 * @param	v			Vector to substract.
		 * @return	a reference to this Vector.
		 */
		public function substract(v:Vector2):Vector2 
		{
			x -= v.x;
			y -= v.y;
			return this;
		}
		
		/**
		 * Returns the difference of 2 Vectors.
		 * @param	v1			Base Vector.
		 * @param	v2			Vector to substract.
		 * @return	The difference between the 2 Vectors.
		 */
		public static function substract(v1:Vector2, v2:Vector2):Vector2
		{
			return new Vector2(v1.x - v2.x, v1.y - v2.y);
		}
		
		/**
		 * Multiply the Vector by a number.
		 * @param	n			Multiply by n.
		 * @return	a reference to this Vector.
		 */
		public function multiply(n:Number):Vector2
		{
			x *= n;
			y *= n;
			return this;
		}
		
		/**
		 * Multiply a Vector by a number.
		 * @param	n			Multiply by n.
		 * @return	the resulting vector.
		 */
		public static function multiply(v:Vector2, n:Number):Vector2
		{
			return new Vector2(v.x * n, v.y * n);
		}
		
		/**
		 * Scale the Vector by a Vector.
		 * @param	v			Multiply by v.
		 * @return	a reference to this Vector
		 */
		public function scaleBy(v:Vector2):Vector2
		{
			x *= v.x;
			y *= v.y;
			return this;
		}
		
		/**
		 * Returns the product of 2 Vectors
		 * @param	v1			Base Vector.
		 * @param	v2			vector to scale By.
		 * @return	The product of the 2 Vectors.
		 */
		public static function scale(v1:Vector2, v2:Vector2):Vector2
		{
			return new Vector2(v1.x * v2.x, v1.y * v2.y);
		}
		
		/**
		 * Normalizes the vector.
		 * @return a reference to this Vector
		 */
		public function normalize():Vector2
		{
			var mag:Number = magnitude;
			if (mag != 0)
			{
				x /= mag;
				y /= mag;
			} else {
				x = 0;
				y = 0;
			}
			return this;
		}
		
		/**
		 * Rotate the Vector by an angle.
		 * @param	a			Rotation angle in Radians.
		 * @return	a reference to this Vector
		 */
		public function rotateBy(a:Number):Vector2
		{
			var tempX:Number = x;
			var tempY:Number = y;
			x = tempX * Math.cos(a) - tempY * Math.sin(a);
			y = tempX * Math.sin(a) + tempY * Math.cos(a);
			return this;	
		}
		
		/**
		 * Project this Vector on another Vector.
		 * @param	v			Vector to project on.
		 * @return	a reference to this Vector.
		 */
		public function projectOn(v:Vector2):Vector2
		{
			var projectedVector:Vector2 = v.normalized.multiply(Vector2.dot(v.normalized, this));
			x = projectedVector.x;
			y = projectedVector.y;
			return this;	
		}
		
		/**
		 * Convert a point into a Vector2
		 * @param	p		point to convert
		 * @return			converted Vector2
		 */
		public static function point(p:Point):Vector2
		{
			return new Vector2(p.x, p.y);
		}
		
		/**
		 * Calculates the distance between two vectors.
		 * @param	v		Distant vector.
		 * @return			Distance between the two vectors.
		 */
		public function distanceTo(v:Vector2):Number 
		{
			var v:Vector2 = Vector2.substract(v, this);
			return v.magnitude;
		}
		
		/**
		 * Calculates the distance between two vectors.
		 * @param	v1		First Vector2.
		 * @param	v2		Second Vector2.
		 * @return			Distance between the two vectors.
		 */
		public static function distanceBetween(v1:Vector2, v2:Vector2):Number
		{
			return v1.distanceTo(v2);
		}
		
		/**
		 * Calculates the angle between two vectors.
		 * @param	v1		First Vector2.
		 * @param	v2		Second Vector2.
		 * @return			Distance between the two vectors.
		 */
		public static function angleBetween(v1:Vector2, v2:Vector2):Number
		{
			//var sign:int = v1.x*v2.y - v1.y*v2.x < 0 ? 1 : -1;
			return /*sign **/ Math.acos(Vector2.dot(v1.normalized, v2.normalized));
		}
		
		/**
		 * Project one Vector along another.
		 * @param	v1			Vector to project.
		 * @param	v2			Vector to project on.
		 * @return	projected Vector.
		 */
		public static function project(v1:Vector2, v2:Vector2):Vector2
		{
			return v2.normalized.multiply(Vector2.dot(v2.normalized, v1));
		}
		
		/**
		 * Calculate the dot product of two vectors.
		 * @param	v1			Vector 1.
		 * @param	v2			Vector 2.
		 * @return	dot product.
		 */
		public static function dot(v1:Vector2, v2:Vector2):Number
		{
			return (v1.x * v2.x + v1.y * v2.y);
		}
		
		/**
		 * Calculate the wedge product of two vectors. if > 0, v2 is left from v1
		 * @param	v1			Vector 1.
		 * @param	v2			Vector 2.
		 * @return	wedge product.
		 */
		public static function wedge(v1:Vector2, v2:Vector2):Number
		{
			return (v1.x * v2.y - v1.y * v2.x);
		}
		
		public function draw(x:Number, y:Number, scale:Number = 1, color:uint = 0xFFFFFF):void {
			
			Draw.line(x, y, x + (this.x * scale), y + (this.y * scale), color);
		}
	}

}