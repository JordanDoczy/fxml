package org.fxml.managers {
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * An asset manager.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	dynamic public class AssetManager extends Proxy {
		
		/**
		 * @private
		 */
		protected var _assets:Dictionary = new Dictionary();
		
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
			return getAsset(name) || null;
		}
		
		/**
		 * Proxy implementation
		 * 
		 * @private
		 */
		override flash_proxy function hasProperty(name:*):Boolean{
			return contains(name);
		}
		
		/**
		 * Proxy implementation
		 * 
		 * @private
		 */
		override flash_proxy function setProperty(name:*, value:*):void{
			addItem(name, value);	
		}
		
		/**
		 * Determines if the assets exists.
		 * 
		 * @param key The asset to check.
		 * 
		 * @return <code>true</code> if the assets exists; otherwise <code>false</code>.
		 */
		public function contains(key:String):Boolean{
			return _assets[key] != null;
		}
		
		/**
		 * Retrieves an asset.
		 * 
		 * @param key The asset to retrieve.
		 * 
		 * @return The value of the asset. 
		 */
		public function getAsset(key:String):*{
			var asset:* = _assets[key];
			if(asset is Bitmap) return new Bitmap((asset as Bitmap).bitmapData.clone());
			else return asset;
		}
		
		/**
		 * Adds an item to the asset manager.
		 * 
		 * @param asset The name of the asset.
		 * @param asset The value of the asset.
		 */
		public function addItem(key:String, asset:*):void{
			_assets[key] = asset;
		}
	}
}