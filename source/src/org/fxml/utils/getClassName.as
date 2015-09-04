package org.fxml.utils {

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Returns the class name of an object.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.2
	 * @date 		15.08.2010
	 * 
	 * @private
	 * 
	 * @object The object to retrieve the class name from.
	 * 
	 * @return The class name of the object.
	 */
	public function getClassName(object:*):Class{
		return Class(flash.utils.getDefinitionByName(getQualifiedClassName(object)));
	}

}
