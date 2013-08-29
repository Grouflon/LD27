package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	
	 [SWF(width = "600", height = "600")]
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(600, 600, 60, false);
			
			Game.init();
		}
		
	}
	
}