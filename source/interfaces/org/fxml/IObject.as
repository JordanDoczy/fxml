package org.fxml {

	/**
	 * @author jordandoczy
	 */
	public interface IObject {
		
		/**
		* Retrieves a property from the Application.
		* @param name The name of the property.
		* @return The value of the property or null 
		*/
		function getProperty(name:String):*;
		
		/**
		* Determines if a property exists on the Application.
		* @param name The name of the property
		* @return true if the property exists, otherwise false
		*/
		function hasProperty(name:String):Boolean;
		
		/**
		* Sets a property on the Application.
		* @param name The name of the property
		* @param value The value to assign to the property
		*/
		function setProperty(name:String, value:*):void;
		
	}
}
