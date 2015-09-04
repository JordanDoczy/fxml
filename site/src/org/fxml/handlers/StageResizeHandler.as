package org.fxml.handlers {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.external.ExternalInterface;

	/**
	 * Calls a JavaScript function anytime the stage is resized;
	 * <p>Included in the swf package: <code>org.fxml.handlers.swf</code></p>
	 * @author jordandoczy
	 */
	public class StageResizeHandler {
		
		private var _callback:String;
		private var _stage:Stage;
		
		/**
		 * @param stage A reference to the stage.
		 * @param callback The JavaScript fucntion to be executed on a stage resize.
		 */
		public function StageResizeHandler(stage:Stage=null, callback:String=null){
			if(stage) this.stage = stage;
			if(callback) this.callback = callback;
		}
		
		/**
		 * The JavaScript fucntion to be executed on a stage resize.
		 */
		public function get callback():String{
			return _callback;
		}
		
		/**
		 * @private
		 */
		public function set callback(value:String):void{
			_callback = value;
			onResize();
		}
		
		/**
		 *  A reference to the stage.
		 */
		public function get stage():Stage{
			return _stage;
		}
		
		/**
		 * @private
		 */
		public function set stage(value:Stage):void{
			_stage = value;
			_stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		/**
		 * @private
		 */
		private function onResize(event:Event=null):void{
			if(stage && callback && ExternalInterface.available){
				ExternalInterface.call(callback, stage.width, stage.height);
			}

		}
		
		
	}
}
