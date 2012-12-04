package  
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Just
	 */
	public class MazeMan extends Sprite
	{
		private var _startPosX:int;
		private var _startPosY:int;
		private var _startPointX:int;
		private var _startPointY:int;
		private var _map:Map;
		private var _step:Point;
		private var _pos:Point;
		private var _timer:Timer;
		
		public static const RELOAD:String = "Reload";
		
		public function MazeMan(map:Map, startPoint:Point) 
		{
			this._map = map;
			this._step = new Point();			
			this._timer = new Timer(100);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);			
			
			_pos = startPoint.clone();
			updatePos();

			graphics.beginFill(0xFFFF00);
			graphics.drawCircle(_map.tileSize / 2, _map.tileSize / 2, _map.tileSize / 2);
			graphics.endFill();
		}
	
		private function keyPressedDown(event:KeyboardEvent):void 
		{
			var key:uint = event.keyCode;
			_step.x = 0;
			_step.y = 0;
			
			switch (key) 
			{
				case Keyboard.LEFT :
					_step.x = -1;
				break;
				case Keyboard.RIGHT :
					_step.x = 1;
				break;
				case Keyboard.UP :
					_step.y = -1;
				break;
				case Keyboard.DOWN :
					_step.y = 1;
				break;
			}
		}
		
		private function onMove(e:Event):void 
		{			
			if (_map.checkTile(_pos.add(_step).x, _pos.add(_step).y))
			{
				//muur
			}
			else
			{
				_pos = _pos.add(_step);
				updatePos();
			}
		}
		
		private function updatePos():void
		{
			this.x = _pos.x * _map.tileSize;
			this.y = _pos.y * _map.tileSize;
			
			if (this.hitTestObject(_map._finishTile))
			{
				dispatchEvent(new Event(RELOAD));
			}
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			this._timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onMove);
		}
		
		public function destroy():void 
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			graphics.clear();
		}
	
	}
}