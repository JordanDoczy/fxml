
package com.yourdomain.display {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	public class Button extends Sprite {
		
		protected const PADDING:uint = 10;
		protected var _textField:TextField; 
		
		public function Button(){
			buttonMode = true;
			mouseChildren = false;
			addTextField();	
		}
		
		public function get label():String{
			return _textField.text;
		}
		
		public function set label(value:String):void{
			_textField.text = value;
		}
		
		public function draw():void{
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, _textField.width+(PADDING*2), _textField.height+(PADDING*2));
			graphics.endFill();
		}
		
		private function addTextField():void{
			_textField = new TextField();
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.multiline = false;
			_textField.selectable = false;
			_textField.textColor = 0xFFFFFF;
			_textField.wordWrap = false;
			_textField.x = PADDING;
			_textField.y = PADDING;
			
			addChild(_textField);
		}
	}
}
