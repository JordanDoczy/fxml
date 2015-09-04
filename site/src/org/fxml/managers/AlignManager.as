package org.fxml.managers {
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * Aligns a DisplayObject on stage resize.
	 * <p>Included in the swf package: <code>org.fxml.managers.swf</code></p>
	 * @author jordandoczy
	 */
	public class AlignManager{
		
		private var _align:String = Align.LEFT;
		private var _target:DisplayObject;
		
		public function AlignManager(){
		}
		
		/**
		 * The alignment of the object.
		 * @see Align
		 */
		public function get align():String{
			return _align;
		}
		
		/**
		 * @private
		 */
		public function set align(value:String):void{
			_align = value;
		}
		
		/**
		 * The DisplayObject to align.
		 */
		public function get target():DisplayObject{
			return _target;
		}
		
		/**
		 * @private
		 */
		public function set target(value:DisplayObject):void{
			_target = value;
			
			if(target.stage){
				_target.stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
				onStageResize();
			}
			else target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}


		private function onAddedToStage(event:Event):void{
			_target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_target.stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
			onStageResize();
		}

		private function onStageResize(event:Event=null):void{
			if(!target.stage) return;
			if(_align == Align.LEFT) return;
			else if(_align == Align.CENTER) _target.x = target.stage.stageWidth /2 - _target.width /2;
			else if(_align == Align.RIGHT) _target.x = target.stage.stageWidth - _target.width;
			
		}
	}
}
