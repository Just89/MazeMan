package
{

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class MazeGenerator
	{
		//directions
		private const NORTH		: String = "N";
		private const SOUTH		: String = "S";
		private const EAST		: String = "E";
		private const WEST		: String = "W";
		
		//variables
		private var _width		: uint;
		private var _height		: uint;
		private var _maze		: Array;
		private var _moves		: Array;
		private var _start		: Point;
		private var _finish		: Point;
		
		public function MazeGenerator (width:int, height:int) : void
		{
			this._height = height;
			this._width = width;
			
			_start	= new Point(1, 1);
			_finish = new Point(_height - 2, _width - 2);
			
			generate();
		}
		
		private function generate () : void
		{
			initMaze();
			createMaze();
		}
		
		private function initMaze () : void
		{
			_maze = new Array(_width);
			for ( var x : int = 0; x < _height; x++ )
			{
				_maze[x] = new Array(_height);
				
				for ( var y : int = 0; y < _width; y++ )
				{
					_maze[x][y] = true;
				}
			}	
			_maze[_start.x][_start.y] = false;
		}
		
		private function createMaze () : void
		{
			var back				: int;
			var move				: int;
			var possibleDirections	: String;
			var pos					: Point = _start.clone();
			
			_moves = new Array();
			_moves.push(pos.y + (pos.x * _width));
			
			while ( _moves.length )
			{
				possibleDirections = "";
				
				if ((pos.x + 2 < _height ) && (_maze[pos.x + 2][pos.y] == true) && (pos.x + 2 != false) && (pos.x + 2 != _height - 1) )
				{
					possibleDirections += SOUTH;
				}
				
				if ((pos.x - 2 >= 0 ) && (_maze[pos.x - 2][pos.y] == true) && (pos.x - 2 != false) && (pos.x - 2 != _height - 1) )
				{
					possibleDirections += NORTH;
				}
				
				if ((pos.y - 2 >= 0 ) && (_maze[pos.x][pos.y - 2] == true) && (pos.y - 2 != false) && (pos.y - 2 != _width - 1) )
				{
					possibleDirections += WEST;
				}
				
				if ((pos.y + 2 < _width ) && (_maze[pos.x][pos.y + 2] == true) && (pos.y + 2 != false) && (pos.y + 2 != _width - 1) )
				{
					possibleDirections += EAST;
				}
				
				if ( possibleDirections.length > 0 )
				{
					move = _randInt(0, (possibleDirections.length - 1));
					
					switch ( possibleDirections.charAt(move) )
					{
						case NORTH: 
							_maze[pos.x - 2][pos.y] = false;
							_maze[pos.x - 1][pos.y] = false;
							pos.x -=2;
							break;
						
						case SOUTH: 
							_maze[pos.x + 2][pos.y] = false;
							_maze[pos.x + 1][pos.y] = false;
							pos.x +=2;
							break;
						
						case WEST: 
							_maze[pos.x][pos.y - 2] = false;
							_maze[pos.x][pos.y - 1] = false;
							pos.y -=2;
							break;
						
						case EAST: 
							_maze[pos.x][pos.y + 2] = false;
							_maze[pos.x][pos.y + 1] = false;
							pos.y +=2;
							break;        
					}
					
					_moves.push(pos.y + (pos.x * _width));
				}
				else
				{
					back = _moves.pop();
					pos.x = int(back / _width);
					pos.y = back % _width;
				}
			}
		}
		
		private function _randInt ( min : int, max : int ) : int 
		{
			return int((Math.random() * (max - min + 1)) + min);
		}
		
		public function get height():uint 
		{
			return _height;
		}
		
		public function get width():uint 
		{
			return _width;
		}
		
		public function get start():Point 
		{
			return _start;
		}
		
		public function get finish():Point 
		{
			return _finish;
		}
		
		public function get maze():Array 
		{
			return _maze;
		}
	}
}