package  
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Just
	 */
	public class loader extends Loader
	{
		
		public function loader(url:String, x:int, y:int) 
		{
			load(new URLRequest(url));
			this.x = x;
			this.y = y;
		}
		
	}

}