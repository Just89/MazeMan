package  
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Just
	 */
	public class Map extends Sprite
	{
		private const WALL_COLOR:uint = 0x000000;
		private const WALKABLE_COLOR:uint = 0xDDDDDD;
			
		private var _maze:MazeGenerator;
		private var _tileSize : Number;	
		private var _points:Array;
		private var _circles:Vector.<Sprite> = new Vector.<Sprite>();
		public var _finishTile:Sprite;
		private var _coin:Coin;
		
		private var _backgroundAgain:Sprite;
	
		public function Map(maze:MazeGenerator) 
		{			
			this._maze = maze;
			this.addEventListener(Event.ADDED_TO_STAGE, drawMaze);
		}
		
		public function checkTile(x:Number,y:Number):Boolean
		{
			return _maze.maze[Math.round(x)][Math.round(y)];
		}
	
		private function drawMaze (e:Event) : void
		{
			var tileWidth:Number = stage.stageWidth / _maze.width;
			var tileHeight:Number = stage.stageHeight / _maze.height;
			
			if (tileWidth > tileHeight)
			{
				_tileSize = tileHeight;
			} 
			else 
			{
				_tileSize = tileWidth;
			}
					
			var tile : Sprite;
			
			for ( var x : int = 0; x < _maze.height; x++ )
			{
				for ( var y : int = 0; y < _maze.width; y++ )
				{
					tile	= (_maze.maze[x][y] == true) ? drawTile(WALL_COLOR) : drawTile(WALKABLE_COLOR);
					tile.x	= x * _tileSize;
					tile.y	= y * _tileSize;
					
					addChild(tile);
				}
			}
			
			//start tile
			tile = drawTile(0xFF0000);
			tile.x = _maze.start.x * _tileSize;
			tile.y = _maze.start.y * _tileSize;
			addChild(tile);
			
			//finish tile	
			_finishTile = new Sprite();
			_finishTile.graphics.beginFill(0x00FF00);
			_finishTile.graphics.drawRect(_maze.finish.x * _tileSize, _maze.finish.y * _tileSize, _tileSize, _tileSize);
			_finishTile.graphics.endFill();
			addChild(_finishTile);
			
			coins();
		}
		
		private function coins():void
		{
			for ( var x:int = 0; x < _maze.height; x++ )
			{
				for ( var y:int = 0; y < _maze.width; y++ )
				{
					if (_maze.maze[x][y] == false)
					{
						_coin = new Coin(_tileSize, x, y);
						addChild(_coin);
						_circles.push(_coin);
					}
				}
			}
		}
		
		private function drawTile(color:uint):Sprite
		{
			var tile : Sprite = new Sprite();
				tile.graphics.beginFill(color);
				tile.graphics.drawRect(0, 0, _tileSize, _tileSize);
				tile.graphics.endFill();
			
			return tile;
		}		
		
		public function get tileSize():Number 
		{
			return _tileSize;
		}
		
		public function get circles():Vector.<Sprite> 
		{
			return _circles;
		}
	}
}