package org.fxml {
	import org.fxml.commands.Command;
	import org.fxml.helpers.ClassBuilderFactory;
	import org.fxml.loaders.BulkLoader;
	import org.fxml.managers.AssetManager;
	import org.fxml.managers.CommandManager;
	import org.fxml.utils.FlashVarUtil;
	import org.fxml.utils.Version;
	import org.fxml.utils.getClassName;

	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 * 
	 * <span class="hide">Note Wrapper.as is used to compile the Application.</span>
	 * 
	 * @author		Jordan Doczy
	 * @version		2.0.0.15
	 * @date 		16.08.2010
	 */
	public class Application extends Sprite implements IObject, IApplication {
		
		/**
		 * @private
		 */
		protected var _debugOutput:flash.text.TextField;
		
		/**
		 * @private
		 */
		protected var _childIndex:uint = 0;
		
		/**
		 * @private
		 */
		protected var _classBuilderFactory:ClassBuilderFactory;
		
		/**
		 * @private
		 */
		protected var _configXML:XML;
		
		/**
		 * @private
		 */
		protected var _commandManager:CommandManager = new CommandManager();
		
		/**
		 * @private
		 */
		protected var _properties:Dictionary = new Dictionary();
		
		/**
		 * @private
		 */
		protected var _urlRequest:URLRequest = new URLRequest();
		
		/**
		 * @private
		 */
		protected var _urlLoader:URLLoader = new URLLoader();
		
		/**
		 * @private
		 */
		protected var _version:Version = new Version(2,1,0,15);
		
		// References to force inclusion in compilation.
		BulkLoader;
		AssetManager;

		/**
		 * Creates a new Application
		 * 
		 * @param configFile The file path to the configuration file to load. 
		 */				
		public function Application(configFile:String){
			
			_urlRequest.url = configFile;
 			_classBuilderFactory = new ClassBuilderFactory(this);
			_classBuilderFactory.addEventListener(Event.COMPLETE, onParsingComplete, false, 0, true);
			addEventListener( Event.ADDED_TO_STAGE, _init, false, 1, true);
		}

		
		/**
		 * Returns the current version of the Application.
		 */
		public function get version():Version{
			return _version;
		}
		
		/**
		 * Returns the request object to configuration file.
		 * 
		 * @private
		 */
		internal function get request():URLRequest{
			return _urlRequest;
		}
		
		
		/**
		 * Retrieves a property from the Application.
		 * 
		 * @param name The name of the property.
		 * 
		 * @return The value of the property or null 
		 */
		public function getProperty(name:String):*{
			try{
				if(_properties[name]) return _properties[name];
				else{
					return getChildByName(name) || this[name];
				}
			}
			catch(e:Error) {
				throw new Error("Could not find property: " + name + " on object " + getClassName(this));
			}	
			return null;
		}
		
		/**
		 * Determines if a property exists on the Application.
		 * 
		 * @param name The name of the property.
		 * 
		 * @return <code>true</code> if the property exists, otherwise <code>false</code>.
		 */
		public function hasProperty(name:String):Boolean{
			try{
					 if(this.hasOwnProperty(name))	return true;
				else if(_properties[name])			return true;
				else 								return contains(getChildByName(name));
			}
			catch(e:Error) {
				
			}
			return false;
		}
		
		/**
		 * Pauses the parser on the Application.
		 * 
		 * @param event An optional event can be passed to this function.
		 */
		public function pause(event:Event=null):void{
			_classBuilderFactory.pause();
		}
		
		/**
		 * Resumes the parser on the Application.
		 * 
		 * @param event An optional event can be passed to this function.
		 */
		public function resume(event:Event=null):void{
			if(event){
				try{
					IEventDispatcher(event.target).removeEventListener(event.type, resume, false);
				}
				catch(e:Error){}
			}
			_classBuilderFactory.resume();
		}
		
		
		/**
		 * Sets a property on the Application.
		 * 
		 * @param name The name of the property.
		 * @param value The value to assign to the property.
		 */
		public function setProperty(name:String, value:*):void{
			if(name == "name") this.name = value;
			
			else if(_properties[name] != value){
				_properties[name] = value;
			}
		}
		
		/**
		 * <p>Replaces all occurances of "flashvars.{string}" where {string} is 
		 * the name of the flash var passed through.</p>
		 * 
		 * @private
		 */
		internal function adjustXML():void{
			var value:String = _configXML.toString();
			var reg:RegExp = /flashvars\.([A-Za-z0-9_]+)/i;
			var matches:Object;
			var result:String;
			var variable:String;
			
			try{
				
				while (matches = reg.exec(value)){ // while not equal to null
					try{
						variable = matches[1];
						result = FlashVarUtil(this, variable);
						value = value.replace(matches[0], result);
						matches = reg.exec(value);
					}
					catch(e:Error) {}
				} 
				
				_configXML = new XML(value);
			}
			catch(e:Error){}
		}
		
		/**
		 * @private
		 * Dispatches an Event.INIT when all objects have been parsed
		 */
		internal function complete():void{
			dispatchEvent(new Event(Event.INIT));
		}
		
		/**
		 * @private
		 * Defines the program flow 
		 */
		internal function _init(event:Event):void{
			removeEventListener( Event.ADDED_TO_STAGE, _init);
			
			_commandManager.addCommand(new Command(_urlLoader.load, _urlLoader, Event.COMPLETE, [request]));
			_commandManager.addCommand(new Command(setXML));
			_commandManager.addCommand(new Command(adjustXML));
			_commandManager.addCommand(new Command(parseXML, this, Event.COMPLETE));
			_commandManager.addCommand(new Command(complete));
			_commandManager.trigger();
		}
		
		/**
		 * Parses the XML.
		 * 
		 * @private
		 */
		internal function parseXML():void{
			_classBuilderFactory.create(_configXML);
		}
		
		/**
		 * Sets the _configXML.
		 * 
		 * @private
		 */
		internal function setXML():void{
			_configXML = XML(_urlLoader.data);
		}
		
		/**
		 * Dispatches an ErrorEvent.
		 * 
		 * @private
		 */
		protected function onLoadingError(event:IOErrorEvent):void{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.text));
		}
		
		/**
		 * Dispatches an a CompleteEvent once parsing has completed.
		 * 
		 * @private
		 */
		protected function onParsingComplete(event:Event):void{
			_classBuilderFactory.removeEventListener(Event.COMPLETE, onParsingComplete);
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * Dispatches a ProgressEvent.
		 * 
		 * @private
		 */
		protected function onProgress(event:ProgressEvent):void{
			dispatchEvent(event);
		}
	}
}