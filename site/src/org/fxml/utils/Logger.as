package	org.fxml.utils {
	import mx.logging.LogEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.utils.describeType;

	/**
	 * @author jordandoczy
	 * @private
	 */
	public class Logger{
		
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		public static var active:Boolean = false;
		public static var ALL:Boolean = false;
		public static var DEBUG:Boolean = false;
		public static var ERROR:Boolean = false;
		public static var EVENT:Boolean = false;
		public static var INFO:Boolean = false;
		public static var LOG:Boolean = false;
		public static var WARNING:Boolean = false;
		
		public static function dispatchEvent(event:Event):Boolean{
			return dispatcher.dispatchEvent(event);
		}
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public static function get isLocal() :Boolean{
			return Capabilities.playerType == "External";
		}
		
		public static function traceObject(o:Object, offset:String=""):void{
			var desc:XML = describeType(o);
			Logger.debug(desc);
			var items:XMLList = desc["variable"];
			var item:XML;
			for each (item in items){
				if(typeof(o[item.@name]) == "object"){
					Logger.debug(offset + "[" + item.@name + "]");
					traceObject(o[item.@name], offset + " ");
				}
				else{
					Logger.debug(offset + item.@name + " : " + o[item.@name]);
				}
			}
		}
		
		public static function debug(value:*):void{
			if(DEBUG || ALL){
				log("DEBUG :: " + value);
				dispatchEvent(new LogEvent(String(value)));
			}
		}
		
		public static function error(value:*):void{
			if(ERROR || ALL){
				log("ERROR :: " + value);
				dispatchEvent(new LogEvent(String(value)));
			}
		}
		
		public static function event(value:*):void{
			if(EVENT || ALL){
				log("EVENT :: " + value);
				dispatchEvent(new LogEvent(String(value)));
			}
		}
		
		public static function info(value:*):void{
			if(INFO || ALL){
				log("INFO :: " + value);
				dispatchEvent(new LogEvent(String(value)));
			}
		}
		
		public static function warning(value:*):void{
			if(WARNING || ALL){
				log("WARNING :: " + value);
				dispatchEvent(new LogEvent(String(value)));
			}
		}
		
		public static function debugObject(o:Object, offset:String=""):void{
			for (var key:String in o){
				if(typeof(o[key]) == "object"){ 
					debug(offset + "[" + key + "]");
					debugObject(o[key], offset+" ");
				}
				else{
					debug(offset + key + ":" + o[key]);
				}
			}
		}
		
		public static function log(value:*):void{
			if(LOG || ALL) trace(value);
		}
		
	}
}