package org.fxml.helpers {

	/**
	 * @author jordandoczy
	 * @private
	 */
	public interface IBuilder {
		
		function convertValue(value:XML):*;
		function hasProperty(instance:Object, property:String):Boolean;
		function isFunction(instance:Object, property:String):Boolean;
		function setProperty(instance:Object, property:String, value:*):void;
	}
}
