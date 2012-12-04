package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Just
	 */
	public class Coin extends Sprite
	{
		private var _tileSize:Number;
		private var _y:Number;
		private var _x:Number;
		
		public function Coin(tileSize:Number, x:Number, y:Number) 
		{
			this._x = x;
			this._y = y;
			this._tileSize = tileSize;
			
			graphics.beginFill(0xD98719);
			graphics.drawCircle(0, 0, _tileSize / 4);
			graphics.endFill();
			this.x = _tileSize * _x + _tileSize / 2;
			this.y = _tileSize * _y + _tileSize / 2;
		}
	}
}