package org.fxml.loaders {
	import flash.display.Loader;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.system.LoaderContext;

	/**
	 * @author jordandoczy
	 */
	public interface IBulkLoader extends IEventDispatcher {
		
		
		/**
		*  Returns the number of assets that have loaded.
		*/
		function get bytesLoaded():uint;
		
		/**
		*  Returns the total number of assets.
		*/
		function get bytesTotal():int;

		/**
		*  Instructs the bulkLoader to load each item sequentially.
		*/
		function get isSequential():Boolean;
		
		/**
		 * @private
		 */
		function set isSequential(value:Boolean):void;
		
		/**
		*  Returns the true if the bulkLoader is still in progress.
		*/
		function get isLoading():Boolean;
		
		
		/**
		* Adds a CSS asset to the bulkLoader.
		*
		* @param path The file path of the asset to load.
		* @param key The name of the asset to retrieve.
		* 
		* @return <code>flash.net.URLLoader</code>
		*
		* @see addItem
		*/
		function addCSS(path:String, key:String=null):URLLoader;

		/**
		* Adds a image asset to the bulkLoader.
		*
		* @param path The file path of the asset to load.
		* @param key The name of the asset to retrieve.
		* 
		* @return <code>flash.display.Loader</code>
		*
		* @see addItem
		*/
		function addImage(path:String, key:String=null):Loader;
		
		/**
		* Adds a SWF asset to the bulkLoader.
		*
		* @param path The file path of the asset to load.
		* @param key The name of the asset to retrieve.
		* @param context The <code>flash.system.LoaderContext</code> in which to load the asset in. 
		* 
		* @return <code>flash.display.Loader</code>
		*
		* @see addItem
		*/
		function addSWF(path:String, key:String=null, context:LoaderContext=null):Loader;
		
		/**
		* Adds an XML asset to the bulkLoader.
		*
		* @param path The file path of the asset to load.
		* @param key The name of the asset to retrieve.
		* 
		* @return <code>flash.net.URLLoader</code>
		*
		* @see addItem
		*/
		function addXML(path:String, key:String=null):URLLoader;
		
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
		* <code>type</code> will return a <code>flash.display.Loader</code>.
		*/
		function addItem(path:String, key:String, type:String, context:LoaderContext=null):*;
		
		/**
		* Retrieves an object from the bulkLoader.
		*
		* @param key The name of the asset to retrieve.
		* 
		* @return The corresponding asset associated with that key.
		*/
		function getAsset(key:String):*;
		
		/**
		* Tells the bulkLoader to begin loading.
		*
		* <p>The <code>load</code> method will trigger the loading
		* of the assets. Once loading has completed a 
		* <code>flash.events.Event.COMPLETE</code> event will be 
		* dispatched</p> 
		*/
		function load():void;
	}
}
