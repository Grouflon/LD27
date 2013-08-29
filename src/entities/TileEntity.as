package entities 
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class TileEntity extends Entity 
	{
		
		public function TileEntity(x:int = 0, y:int = 0) 
		{
			this.x = x;
			this.y = y;
		}
		
		override public function render():void {
			var tempX:Number = x;
			var tempY:Number = y;
			
			x = tempX * Game.tileWidth;
			y = tempY * Game.tileHeight;
			
			super.render();
			
			x = tempX;
			y = tempY;
		}
		
		public function moveUp():void { y-- }
		public function moveRight():void { x++ }
		public function moveDown():void { y++ }
		public function moveLeft():void { x-- }
		
	}

}