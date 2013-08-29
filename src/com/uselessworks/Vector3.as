package com.uselessworks
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Rémi Bismuth @uselessworks.com
	 */
	
	 /**
	 * 3 Dimensional Vector class.
	 */
	public class Vector3 extends Object
	{
		/**
		 * x Component of the Vector.
		 */
		public var x:Number = 0;
		/**
		 * y Component of the Vector.
		 */
		public var y:Number = 0;
		/**
		 * z Component of the Vector.
		 */
		public var z:Number = 0;
		/**
		 * Direction of the Vector in Radians.
		 * @return Vector2 where x is horizontal direction and y vertical direction
		 */
		/*public function get directionR():Vector2 
		{
			var angle:Vector2 = new Vector2;
			//horizontal component
			angle.x = new Vector2(x, y).directionR;
			
			//vertical component
			angle.y = new Vector2(y, z).directionR;
			
			return angle;
		}*/
		/**
		 * Direction of the Vector in Degrees.
		 */
		/*public function get directionD():Vector2 { 
			return (new Vector2(directionR.x * 180 / Math.PI, directionR.y * 180 / Math.PI)); 
			}*/
		/**
		 * Magnitude of the Vector.
		 */
		public function get magnitude():Number { return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2) + Math.pow(z,2)) }
		public function set magnitude(value:Number):void { this.normalize().multiply(value) }
		/**
		 * [Read-only] Squared Magnitude of the Vector.
		 */
		public function get magnitude2():Number { return (Math.pow(x, 2) + Math.pow(y, 2) + Math.pow(z,2)) }
		/**
		 * [Read-only] Normalized Vector.
		 */
		public function get normalized():Vector3 { 
			if (magnitude != 0)
			{
				return new Vector3(x / magnitude, y / magnitude, z / magnitude); 
			} else {
				return new Vector3; 
			}
		}
		/**
		 * [Read-only] Horizontal component of the Vector
		 */
		public function get XZ():Vector3 { return new Vector3(x, 0, z); }
		/**
		 * [Read-only] Right perpendicular Vector.
		 */
		public function get opposite():Vector3 { return new Vector3( -x, -y, -z); }
		
		public static const X:Vector3 = new Vector3(1, 0, 0);
		public static const Y:Vector3 = new Vector3(0, 1, 0);
		public static const Z:Vector3 = new Vector3(0, 0, 1);
		
		/**
		 * Constructor. Can be used to assign Vector Components.
		 * @param	x			X position to place the Entity.
		 * @param	y			Y position to place the Entity.
		 */
		public function Vector3(x:Number = 0, y:Number = 0, z:Number = 0):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function toString():String
		{
			return '( ' + x + ', ' + y + ', ' + z + ' )';
		}
		
		/**
		 * Adds a Vector to the current one.
		 * @param	v			Vector to add.
		 * @return	a reference to this Vector.
		 */
		public function add(v:Vector3):Vector3 
		{
			x += v.x;
			y += v.y;
			z += v.z;
			return this;
		}
		
		/**
		 * Returns the sum of 2 Vectors.
		 * @param	v1			Base Vector.
		 * @param	v2			Vector to add.
		 * @return	The sum of the 2 Vectors.
		 */
		public static function add(v1:Vector3, v2:Vector3):Vector3
		{
			return new Vector3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
		}
		
		/**
		 * Substract a Vector to the current one.
		 * @param	v			Vector to substract.
		 * @return	a reference to this Vector.
		 */
		public function substract(v:Vector3):Vector3
		{
			x -= v.x;
			y -= v.y;
			z -= v.z;
			return this;
		}
		
		/**
		 * Returns the difference of 2 Vectors.
		 * @param	v1			Base Vector.
		 * @param	v2			Vector to substract.
		 * @return	The difference between the 2 Vectors.
		 */
		public static function substract(v1:Vector3, v2:Vector3):Vector3
		{
			return new Vector3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
		}
		
		/**
		 * Multiply the Vector by a number.
		 * @param	n			Multiply by n.
		 * @return	a reference to this Vector.
		 */
		public function multiply(n:Number):Vector3
		{
			x *= n;
			y *= n;
			z *= n;
			return this;
		}
		
		/**
		 * Multiply a Vector by a number.
		 * @param	n			Multiply by n.
		 * @return	the resulting vector.
		 */
		public static function multiply(v:Vector3, n:Number):Vector3
		{
			return new Vector3(v.x * n, v.y * n, v.z * n);
		}
		
		/**
		 * Scale the Vector by a Vector.
		 * @param	v			Multiply by v.
		 * @return	a reference to this Vector
		 */
		public function scaleBy(v:Vector3):Vector3
		{
			x *= v.x;
			y *= v.y;
			z *= v.z;
			return this;
		}
		
		/**
		 * Returns the product of 2 Vectors
		 * @param	v1			Base Vector.
		 * @param	v2			vector to scale By.
		 * @return	The product of the 2 Vectors.
		 */
		public static function scale(v1:Vector3, v2:Vector3):Vector3
		{
			return new Vector3(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z);
		}
		
		/**
		 * Normalizes the vector.
		 * @return a reference to this Vector
		 */
		public function normalize():Vector3
		{
			var mag:Number = magnitude;
			if (mag != 0)
			{
				x /= mag;
				y /= mag;
				z /= mag;
			} else {
				x = 0;
				y = 0;
				z = 0;
			}
			return this;
		}
		
		/**
		 * Rotate the Vector by two angles.
		 * @param	a			Vector 2 where x is the rotation around z and y the rotation around x
		 * @return				a reference to this Vector
		 */
		/*public function rotateBy(a:Vector2):Vector3
		{
			var tempX:Number = x;
			var tempY:Number = y;
			var tempZ:Number = y;
			
			x = tempX * Math.cos(a.x) - tempY * Math.sin(a.x);
			y = tempX * Math.sin(a.x) + tempY * Math.cos(a.x);
			z = tempY * Math.cos(a.y) - tempZ * Math.sin(a.y);
			return this;	
		}*/
		
		/**
		 * Project this Vector on another Vector.
		 * @param	v			Vector to project on.
		 * @return	a reference to this Vector.
		 */
		public function projectOn(v:Vector3):Vector3
		{
			var projectedVector:Vector3 = v.normalized.multiply(Vector3.dot(v.normalized, this));
			x = projectedVector.x;
			y = projectedVector.y;
			y = projectedVector.z;
			return this;	
		}
		
		/**
		 * Project one Vector along another.
		 * @param	v1			Vector to project.
		 * @param	v2			Vector to project on.
		 * @return	projected Vector.
		 */
		public static function project(v1:Vector3, v2:Vector3):Vector3
		{
			return v2.normalized.multiply(Vector3.dot(v2.normalized, v1));
		}
		
		/**
		 * Calculate the dot product of two vectors.
		 * @param	v1			Vector 1.
		 * @param	v2			Vector 2.
		 * @return	dot product.
		 */
		public static function dot(v1:Vector3, v2:Vector3):Number
		{
			return (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z);
		}
		
		/**
		 * Calculate the cross product of two vectors.
		 * @param	v1			Vector 1.
		 * @param	v2			Vector 2.
		 * @return	cross product.
		 */
		public static function cross(v1:Vector3, v2:Vector3):Vector3
		{
			return (new Vector3(
				v1.y * v2.z - v1.z * v2.y,
				v1.z * v2.x - v1.x * v2.z,
				v1.x * v2.y - v1.y * v2.x
			));
		}
	}

}