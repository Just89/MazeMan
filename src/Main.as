package 
{
	import flash.accessibility.ISimpleTextSelection;
	import flash.automation.KeyboardAutomationAction;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Just
	 */
	public class Main extends Sprite 
	{
		private var _background:Sprite = new Sprite();
		
		private var _made:TekstField;
		private var _cointText:TekstField;
		private var _timerText:TekstField;
		private var _levelText:TekstField;
		private var _highScoreText:TekstField;
		private var _subTitle:TekstField;
		
		private var _mazeMan:MazeMan;
		private var _map:Map;
		private var _timer:Timer;
		
		//time give to play the game
		private var _timerTime:int = 181;
		private var _totalCoins:int = 0;
		private var _level:int = 0;
		private var _highScore:int = 0;
		
		private var _title:loader
		private var _play:loader;
		private var _gameover:loader;
		private var _playagain:loader;
		private var _controls:loader
		private var _back:loader;
		
		public function Main():void 
		{
			_background.graphics.beginFill(0x000000);
			_background.graphics.drawRect(0, 0, 800, 600);
			_background.graphics.endFill();
			addChild(_background);
			
			if (stage) onStage();
			else addEventListener(Event.ADDED_TO_STAGE, onStage);
		
			startScreen();
		}
	
		private function init(e:Event = null):void 
		{
			_level++;
			
			var _maze:MazeGenerator = new MazeGenerator(40+1,40+1);
			
			_map = new Map(_maze);
			addChild(_map);
			
			_mazeMan = new MazeMan(_map, _maze.start);
			addChild(_mazeMan);
			
			_mazeMan.addEventListener(MazeMan.RELOAD, onReload);
		
			_timerText = new TekstField("Time left: ", 0xFFFFFF, false, 610,10);
			addChild(_timerText);

			_levelText = new TekstField("Maze level: " + _level, 0xFFFFFF, false, 610,25);
			addChild(_levelText);
			
			_cointText = new TekstField("Total Coins: ", 0xFFFFFF, false, 610,40);
			addChild(_cointText);
			
			_highScoreText = new TekstField("Current Score: " + (_level * _totalCoins), 0xFFFFFF, false, 610,55);
			addChild(_highScoreText);
			
			if (_subTitle.parent != null)
			{
				removeChild(_subTitle);
			}
			
			_timer.start();
			
			addEventListener(Event.ENTER_FRAME, onCoin);	
		}
		
		private function onCoin(e:Event):void 
		{
			var x:int = Math.round(_mazeMan.x / _map.tileSize);
			var y:int = Math.round(_mazeMan.y / _map.tileSize);
			for (var i:int = 0; i < _map.circles.length; i++)
			{
				if (Math.round(_map.circles[i].x / _map.tileSize) == x && Math.round(_map.circles[i].y / _map.tileSize) == y)
				{
					if (_map.circles[i].parent != null)
					{
						if (_map.removeChild(_map.circles[i]))
						{
							_cointText.text = "Total Coins: " + String(_totalCoins++);
							_highScoreText.text = "High Score: " + (_level * _totalCoins);
						}
					}	
				}
			}
		}
		
		private function countdown(event:TimerEvent):void
		{
			var totalSecondsLeft:Number = event.currentTarget.delay * (event.currentTarget.repeatCount - event.currentTarget.currentCount) / 1000;
			_timerText.text = "Time left: " + String(timeFormat(totalSecondsLeft));
			
			if (totalSecondsLeft == 0)
			{
				gameOver();
			}
		}
		
		private function timeFormat(seconds:int):String 
		{
			var minutes:int;
			var sMinutes:String;
			var sSeconds:String;
			if(seconds > 59) {
				minutes = Math.floor(seconds / 60);
				sMinutes = String(minutes);
				sSeconds = String(seconds % 60);
			} else 
			{
				sMinutes = "00";
				sSeconds = String(seconds);
			}
			if (sSeconds.length == 1) 
			{
				sSeconds = "0" + sSeconds;
			}
			return sMinutes + ":" + sSeconds;
		}
		
		private function onReload(e:Event):void 
		{
			_mazeMan.removeEventListener(MazeMan.RELOAD, onReload);
			_mazeMan.destroy();
			removeChild(_levelText);
			removeChild(_cointText);
			removeChild(_timerText);
			removeChild(_highScoreText);
			removeChild(_mazeMan);
			removeChild(_map);
			init();
		}

		private function startScreen():void
		{
			_title = new loader("images/maze_man.png", 250, 100);
			addChild(_title);
			
			_subTitle = new TekstField("'Complete as many Mazes as you can while collecting as many coins as you can under 3 minutes'", 0xFFFFFF, false, 165, 180);
			_subTitle.width = 500;
			addChild(_subTitle);
			
			_play = new loader("images/play.png", 390, 300)
			addChild(_play);
			
			_controls = new loader("images/controls.png", 370, 320)
			addChild(_controls);
			
			_controls.addEventListener(MouseEvent.CLICK, controls);
			
			_made = new TekstField("Made by Justian Lutteke", 0xFFFFFF, false, 345, 500);
			_made.width = 150;
			addChild(_made);
			
			_timer = new Timer(1000, _timerTime);
			_timer.addEventListener(TimerEvent.TIMER, countdown);
					
			_play.addEventListener(MouseEvent.CLICK, init);
		}
		
		private function gameOver():void
		{
			_mazeMan.destroy();
			removeChild(_timerText);
			
			if (_play.parent != null)
			{
				removeChild(_play);
			}
			if (_controls.parent != null)
			{
				removeChild(_controls);
			}
			removeChild(_mazeMan);
			removeChild(_map);
			_timer.stop();
			
			_gameover = new loader("images/game_over.png", 240, 100);			
			addChild(_gameover);
			
			_made.x = 345;
			
			_cointText.x = 368;
			_cointText.y = 270;
			
			_levelText.x = 372;
			_levelText.y = 285;
			
			_highScoreText.x = 370;
			_highScoreText.y = 300;
			
			_playagain = new loader("images/play_again.png", 365, 320);
			addChild(_playagain);
			
			_playagain.addEventListener(MouseEvent.CLICK, playAgain);
		}
		
		private function playAgain(e:MouseEvent):void 
		{
			removeEventListener(MouseEvent.CLICK, playAgain);
			_level = 0;
			removeChild(_gameover);
			removeChild(_highScoreText);
			removeChild(_levelText);
			removeChild(_cointText);
			removeChild(_playagain);
			_timer.reset();
			init();
		}
		
				
		private function controls(e:MouseEvent):void 
		{
			removeChild(_controls);
			removeChild(_play);
			
			_controls = new loader("images/keyboard-arrows.png", 270, 200);
			addChild(_controls);
			
			_back = new loader("images/back.png", 385, 375);
			addChild(_back);
			
			_back.addEventListener(MouseEvent.CLICK, back);
		}
		
		private function back(e:MouseEvent):void 
		{
			removeChild(_controls);
			removeChild(_back);
			startScreen();
		}
		
		private function onStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
		}
				
	}
}