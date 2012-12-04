package  
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Just
	 */
	public class TekstField extends TextField
	{
		
		public function TekstField(text:String, color:uint, select:Boolean, x:int, y:int) 
		{
			this.text = text;
			this.textColor = color;
			this.selectable = select;
			this.x = x
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
	}

}