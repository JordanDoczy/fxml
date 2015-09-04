package org.fxml.containers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * A ViewStack navigator container consists of a collection of child 
	 * containers stacked on top of each other, where only one child at a time is visible. 
	 * When a different child container is selected, it seems to replace the old one because 
	 * it appears in the same location. However, the old child container still exists; it is just invisible.
	 * <p>Included in the swf package: <code>org.fxml.containers.swf</code></p>
	 * @author jordandoczy
	 */
	public class ViewStack extends Sprite
	{
		private var _selectedIndex:int = -1;
		private var _children:Array = new Array();
		
		/**
		* @private
		*/	
		override public function addChild(child:DisplayObject):DisplayObject{
			super.addChild(child);
			child.visible = false;
			_children.push(child);		
			return child;
		}
		
		/**
		* Returns the current child.
		*/
		public function get currentChild():DisplayObject{
			if(_selectedIndex < 0 || _selectedIndex >= _children.length) return null;
			else return _children[_selectedIndex]; 
		}
		
		/**
		* Returns the height of the ViewStack. This is determined by the current child's height. 
		*/
		public override function get height():Number{
			if(currentChild) return currentChild.height;
			else return 0;
		}
		
		/**
		* Returns the total number of items in the ViewStack. 
		*/
		public function get length():uint{
			return _children.length;
		}

		[Bindable("change")]
		/**
		* Determines which child in the ViewStack is active. 
		*/
		public function get selectedIndex():int{
			return int(_selectedIndex);
		}
		
		/**
		 * @private
		 */
		public function set selectedIndex(index:int):void
		{
			if (index === _selectedIndex || index < 0) return; // must be new index
			if (currentChild) currentChild.visible = false; // hide previous child

			_selectedIndex = index;
			
			currentChild.visible = true;
			try{
				setChildIndex(currentChild, numChildren-1); // force to top
			}
			catch(e:Error){}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		* Returns the width of the ViewStack. This is determined by the current child's width. 
		*/
		public override function get width():Number{
			if(currentChild) return currentChild.width;
			else return 0; 
		}
	}
}
