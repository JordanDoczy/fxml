package org.fxml.containers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * A Box container lays out its children in a single vertical column or a single horizontal row. 
	 * The <code>direction</code> property determines whether to use vertical (default) or horizontal layout.
	 * <p>Included in the swf package: <code>org.fxml.containers.swf</code></p> 
	 * @author jordandoczy
	 */
	public class Box extends Sprite {
		
		/**
		* @private
		*/
		protected var _adjustment:uint = 0;
		/**
		* @private
		*/
		protected var _direction:String;
		/**
		* @private
		*/
		protected var _items:Array = new Array();
		/**
		* @private
		*/
		protected var _padding:Number = 0;

		/**
		* Determines the layout of the Box.
		* @see BoxDirection
		*/
		public function get direction():String{
			return _direction;
		}
		
		/**
		* @private
		*/
		public function set direction(value:String):void{
			_direction = value;
		}
		
		/**
		* Determines the amount of space between each child.
		*/
		public function get padding():Number{
			return _padding;
		}
		
		/**
		* @private
		*/
		public function set padding(value:Number):void{
			_padding = value;
		}
		
		/**
		* @private
		*/
		public override function addChild(content:DisplayObject):DisplayObject{
			
			if(_direction == BoxDirection.HORIZONTAL){
				content.x = _adjustment;
				if(content is TextField) _adjustment += TextField(content).textWidth + _padding;
				else _adjustment += content.width + _padding;	
			}
			else{ // VERTICAL
				content.y = _adjustment;
				if(content is TextField) _adjustment += TextField(content).textHeight + _padding;
				else _adjustment += content.height + _padding;	
			}
			
			_items.push(content);
			
			return super.addChild(content);
		}
		
		/**
		* Removes all children.
		*/
		public function clear():void{
			var child:DisplayObject;
			for each (child in _items){
				removeChild(child);
			}
			_items = new Array();
			_adjustment = 0;
		}
	}
}
