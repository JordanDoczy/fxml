package org.fxml.loaders {
	import org.fxml.commands.Command;
	import org.fxml.constants.AssetTypes;
	import org.fxml.managers.AssetManager;
	import org.fxml.managers.CommandManager;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * Dispatched when all assets have finished loading.
	 * @eventType <code>flash.events.Event.COMPLETE</code>
	 */ 
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * Dispatched every time an asset has finshed loading.
	 * @eventType <code>flash.events.ProgressEvent.PROGRESS</code>
	 */ 
	[Event(name="progress", type="flash.events.ProgressEvent")]
	 
	 /**
	 * The BulkLoader class is used to load multiple assets.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.20
	 * @date 		15.08.2010
	 */
	public class BulkLoader extends Proxy implements IBulkLoader {
		
		
		/**
		 * @private
		 */
		protected var _assetManager:AssetManager = new AssetManager();
		
		/**
		 * @private
		 */
		protected var _bytesLoaded:uint = 0;
		
		/**
		 * @private
		 */
		protected var _commandManager:CommandManager = new CommandManager();
		
		/**
		 * @private
		 */
		protected var _dictionary:Dictionary = new Dictionary();
		
		/**
		 * @private
		 */
		protected var _dispatcher:IEventDispatcher = new EventDispatcher(); 
		
		/**
		 * @private
		 */
		protected var _items:Array = new Array();
		
		/**
		 * Creates a BulkLoader.
		 * 
		 * @assetManager The asset manager to store the assets.
		 */
		public function BulkLoader(assetManager:AssetManager=null){
			_assetManager = assetManager || new AssetManager();
			_commandManager.addEventListener(Event.COMPLETE, onCommandManagerComplete, false, 0, true);
			_commandManager.isSequential = false;
		}
		
		/* Proxy implementation */
		/**
		 * Proxy implementation
		 * 
		 * @private
		 */
		override flash_proxy function callProperty(methodName:*, ... args):* {
			return (this[methodName] as Function).apply(this, args);
	    }
	    
		/**
		 * Proxy implementation
		 * 
		 * @private
		 */
		override flash_proxy function getProperty(name:*):*{
			return _assetManager.getAsset(name) || null;
		}
		
		/**
		 * Proxy implementation
		 * 
		 * @private
		 */
		override flash_proxy function hasProperty(name:*):Boolean{
			return _assetManager.contains(name);
		}
		
		/**
		 * Proxy implementation
		 * 
		 * @private
		 */
		override flash_proxy function setProperty(name:*, value:*):void{
			_assetManager.addItem(name, value);	
		}
		
		/* IEventDispatcher implementation */
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		 * 
		 * @param type The type of event.
		 * @param listener The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing.
		 * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases. If <code>useCapture</code> is set to <code>true</code>, the listener processes the event only during the capture phase and not in the target or bubbling phase. If <code>useCapture</code> is <code>false</code>, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call <code>addEventListener</code> twice, once with <code>useCapture</code> set to <code>true</code>, then again with <code>useCapture</code> set to <code>false</code>.
		 * @param priority he priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.
		 * @param useWeakReference Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher object upon which the <code>dispatchEvent()</code> method is called.
		 * 
		 * @param event The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its <code>target</code> property cannot be changed, so you must create a new copy of the event for redispatching to work.
		 * 
		 * @return A value of <code>true</code> if the event was successfully dispatched. A value of <code>false</code> indicates failure or that preventDefault() was called on the event. 
		 */
		public function dispatchEvent(event:Event):Boolean{
			return _dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event. 
		 * 
		 * @param type The type of event.
		 * 
		 * @return A value of <code>true</code> if a listener of the specified type is registered; <code>false</code> otherwise.
		 */
		public function hasEventListener(type:String):Boolean{
			return _dispatcher.hasEventListener(type);
		}
		
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
		 * 
		 * @param type The type of event.
		 * @param listener The listener object to remove.
		 * @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to <code>removeEventListener()</code> are required to remove both, one call with <code>useCapture()</code> set to <code>true</code>, and another call with <code>useCapture()</code> set to <code>false</code>.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type. This method returns true if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
		 * 
		 * @type The type of event.
		 * 
		 * @return A value of <code>true</code> if a listener of the specified type will be triggered; <code>false</code> otherwise.
		 */
		public function willTrigger(type:String):Boolean{
			return _dispatcher.willTrigger(type);
		}
		
		
		/* PUBLIC PROPERTIES */
		/**
		 * Returns the number of assets that have loaded.
		 * @default 0
		 */
		public function get bytesLoaded():uint{
			return _bytesLoaded;
		}
		
		/**
		 * Returns the total number of assets.
		 * @default 0
		 */
		public function get bytesTotal():int{
			return _items.length;
		}
		
		/**
		 * Returns the <code>true</code> if the bulkLoader is still in progress.
		 * @default <code>false</code>
		 */
		public function get isLoading():Boolean{
			return _commandManager.isWorking;
		}
		
		/**
		 * Instructs the bulkLoader to load each item sequentially.
		 * @default <code>false</code> 
		 */
		public function get isSequential():Boolean{
			return _commandManager.isSequential = false;
		}
		
		/**
		 * @private
		 */
		public function set isSequential(value:Boolean):void{
			_commandManager.isSequential = value;
		}
		
		/* PUBLIC METHODS */
		/**
		 * Adds a CSS asset to the bulkLoader.
		 *
		 * @param path The file path of the asset to load.
		 * @param key The name of the asset to retrieve.
		 * 
		 * @see addItem
		 */
		public function addCSS(path:String, key:String=null):URLLoader{
			key = key || path;
			return addItem(path, key, AssetTypes.CSS);		
		}
		
		/**
		 * Adds a image asset to the bulkLoader.
		 *
		 * @param path The file path of the asset to load.
		 * @param key The name of the asset to retrieve.
		 * 
		 * @see addItem
		 */
		public function addImage(path:String, key:String=null):Loader{
			key = key || path;
			return addItem(path, key, AssetTypes.IMG);
		}
		
		/**
		 * Adds a SWF asset to the bulkLoader.
		 *
		 * @param path The file path of the asset to load.
		 * @param key The name of the asset to retrieve.
		 * @param context The <code>flash.system.LoaderContext</code> in which to load the asset in. 
		 * 
		 * @see addItem
		 */
		public function addSWF(path:String, key:String=null, context:LoaderContext=null):Loader{
			key = key || path;
			context = context || new LoaderContext(true, ApplicationDomain.currentDomain);
			return addItem(path, key, AssetTypes.SWF, context);
		}
		
		/**
		 * Adds an XML asset to the bulkLoader.
		 *
		 * @param path The file path of the asset to load.
		 * @param key The name of the asset to retrieve.
		 * 
		 * @see addItem
		 */
		public function addXML(path:String, key:String=null):URLLoader{
			key = key || path;
			return addItem(path, key, AssetTypes.XML);
		}
		
		/**
		 * Adds an item to the bulkLoader.
		 *
		 * @param path The file path of the asset to load.
		 * @param key The name of the asset to retrieve.
		 * @param type The type of asset to load. (@see org.fxml.constants.AssetTypes)
		 * @param context The <code>flash.system.LoaderContext</code> in which to load the asset in.
		 * 
		 * @return Depending on the <code>type</code> a <code>flash.net.URLLoader</code>
		 * or a <code>flash.display.Loader</code> will be returned. An asset of <code>type</code>
		 * "css" or "xml" will return a <code>flash.net.URLLoader</code>, while an asset of 
		 * <code>type</code> "swf" or "img" will return a <code>flash.display.Loader</code>.
		 */
		public function addItem(path:String, key:String, type:String, context:LoaderContext=null):*{
			
			var request:URLRequest = new URLRequest(path);
			var params:Array;
			var loader:*;

			switch(type){
				case AssetTypes.CSS:
				case AssetTypes.XML:
					loader = createURLLoader();
				break;	
				case AssetTypes.IMG:
				case AssetTypes.SWF:
					loader = createLoader();
				break;	
			}
			
			_dictionary[loader] = new LoadObject(loader, key, context, type);
			_items.push(loader);
			return loader;
			
			function createURLLoader():URLLoader{
				params = [request];
				var loader:URLLoader = new URLLoader();
					loader.addEventListener(Event.COMPLETE, onAssetLoaded, false, 1, true);
				_commandManager.addCommand(new Command(loader.load, loader, Event.COMPLETE, params));
				return loader; 	
			}
			
			function createLoader():Loader{
				params = [request, context];
				var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded, false, 1, true);
				_commandManager.addCommand(new Command(loader.load, loader.contentLoaderInfo, Event.COMPLETE, params));
				return loader;		
			}
		}
		
		/**
		 * Retrieves an object from the bulkLoader.
		 *
		 * @param key The name of the asset to retrieve.
		 * 
		 * @return The corresponding asset associated with that key.
		 */
		public function getAsset(key:String):*{
			return _assetManager.getAsset(key);
		}
		
		/**
		 * Tells the bulkLoader to begin loading.
		 *
		 * <p>The <code>load</code> method will trigger the loading
		 * of the assets. Once loading has completed a 
		 * <code>flash.events.Event.COMPLETE</code> event will be 
		 * dispatched</p> 
		 */
		public function load():void{
			_commandManager.trigger();
		}
		
		
		/* PROTECTED METHODS */
		/**
		 * Handler for loader objects. When invoked the result of the loader will be stored in the asset manager.
		 * 
		 * <p>Dispatches a <code>flash.events.ProgressEvent.PROGRESS</code></p>
		 * 
		 * @private
		 */
		protected function onAssetLoaded(event:Event):void{
			var loader:*;
			var loadObject:LoadObject;
			var result:*;
			
			if(event.target is LoaderInfo){
				loader = Loader(LoaderInfo(event.target).loader);
				(loader as Loader).contentLoaderInfo.removeEventListener(Event.COMPLETE, onAssetLoaded);
				loadObject = _dictionary[loader];
				result = (loader as Loader).content;
			}
			else{
				loader = URLLoader(event.target);
				(loader as URLLoader).removeEventListener(Event.COMPLETE, onAssetLoaded);
				
				loadObject = _dictionary[loader];
				
				if(loadObject.type == AssetTypes.CSS){
					var styleSheet:StyleSheet = new StyleSheet();
					styleSheet.parseCSS((loader as URLLoader).data);
					result = styleSheet;
				}
				else if(loadObject.type == AssetTypes.XML){
					result = new XML((loader as URLLoader).data);
				}
				else{
					result = (loader as URLLoader).data;
				}
			}
			
			_assetManager.addItem(loadObject.key, result);
			_bytesLoaded++;
			
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, true, false, bytesLoaded, bytesTotal));
		}
		
		/**
		 * Dispatches a <code>flash.events.Event.COMPLETE</code> event once all loaders have completed.
		 * 
		 * @private
		 */
		protected function onCommandManagerComplete(event:Event):void{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}

import flash.system.LoaderContext;

/**
 * Helper Class.
 * 
 * <p>Used to store information about a asset loader.</p>
 * 
 * @private
 */
class LoadObject{
	public var loader:*;
	public var key:String;
	public var context:LoaderContext;
	public var type:String;
	
	/**
	 * Creates a LoadObject
	 * 
	 * @param loader An object of type <code>flash.display.Loader</code> or <code>flash.net.URLLoader</code>.
	 * @param key A key associated with the loader.
	 * @param context The context to loader the asset within.
	 * @param type The asset type @see AssetTypes
	 */
	public function LoadObject(loader:*, key:String, context:LoaderContext, type:String){
		this.loader = loader;
		this.key = key;
		this.context = context;
		this.type = type;
	}
}
