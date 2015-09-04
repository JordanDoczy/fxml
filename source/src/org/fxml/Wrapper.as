package org.fxml {
	import org.fxml.constants.Keywords;
	import org.fxml.utils.FlashVarUtil;
	import org.fxml.utils.Version;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @Main class from which the Application is built
	 * 
	 * <p>Wrapper class that defers methods calls to the Application.</p>
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class Wrapper extends Sprite implements IObject, IApplication {
		
		private var _application:Application;
		
		/**
		 * Creates a Wrapper
		 */
		public function Wrapper(){
			_application = new Application(FlashVarUtil(this, Keywords.CONFIG_FILE));
			super.addChild(_application);
		}
		
		public override function addChild(child:DisplayObject):DisplayObject{
			return _application.addChild(child);
		}
		
		public function get version():Version{
			return _application.version;
		}
		
		public function getProperty(name:String):*{
			return _application.getProperty(name);
		}
		
		public function hasProperty(name:String):Boolean{
			return _application.hasProperty(name);
		}
		
		public function setProperty(name:String, value:*):void{
			_application.setProperty(name, value);
		}
		
		public function pause(event:Event=null):void{
			_application.pause(event);
		}
		
		public function resume(event:Event=null):void{
			_application.resume(event);
		}
	}
}
