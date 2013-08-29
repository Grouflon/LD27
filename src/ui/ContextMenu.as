package ui 
{
	import actions.Action;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import flash.utils.describeType;
	/**
	 * ...
	 * @author Rémi @ www.uselessworks.com
	 */
	public class ContextMenu extends Entity
	{
		private var _actions:Vector.<Class>;
		private var _lineHeight:int = 20;
		private var _padding:int = 15;
		private var _cursorPadding:int = 10;
		private var _currentIndex:int;
		
		private var _cursor:Image;
		
		public function ContextMenu(x:int, y:int, actions:Vector.<Class>)
		{
			_actions = actions;
			this.x = x;
			this.y = y;
		}
		
		override public function added():void {
			_currentIndex = 0;
			_generateGraphic();
			
			Events.onKeyUpPressed.add(moveCursorUp);
			Events.onKeyDownPressed.add(moveCursorDown);
			
			Events.onContextMenuOpen.dispatch();
		}
		
		public function executeAction():void {
			Events.onActionTriggered.dispatch(_actions[_currentIndex]);
			close();
		}
		
		private function _generateGraphic():void {
			var gl:Graphiclist = new Graphiclist();
			
			var textGraphics:Graphiclist = new Graphiclist();
			var actionTexts:Vector.<Text> = new Vector.<Text>;
			
			var i:int = 0;
			var maxWidth:int = 0;
			
			for each (var action:Class in _actions) {
				var text:Text = new Text(action['name'], _padding + _cursorPadding, _padding + i * _lineHeight);
				
				if (text.width > maxWidth) {
					maxWidth = text.width;
				}
				
				textGraphics.add(text);
				
				i++;
			}
			
			var bg:Image = Image.createRect(maxWidth + (_padding * 2) + _cursorPadding, i * _lineHeight + (_padding * 2), 0x000000, 0.5);
			_cursor = Image.createRect(5, 5);
			_cursor.x = _padding;
			gl.add(bg);
			gl.add(textGraphics);
			gl.add(_cursor);
			
			graphic = gl;
			setHitboxTo(bg);
		}
		
		public function moveCursorUp():void {
			if (_currentIndex > 0) {
				_currentIndex--;
			} else {
				_currentIndex = _actions.length - 1;
			}
		}
		
		public function moveCursorDown():void {
			
			if (_currentIndex < _actions.length - 1) {
				_currentIndex++;
			} else {
				_currentIndex = 0;
			}
		}
		
		public function moveCursorAt(i:int):void {
			_currentIndex = i;
		}
		
		public function close():void {
			Game.level.remove(this);
			Events.onContextMenuClose.dispatch();
		}
		
		override public function update():void {
			_cursor.y = _currentIndex * _lineHeight + _lineHeight / 2 + _padding - _cursor.height / 2;
		}
	}
}