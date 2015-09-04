package org.fxml.utils {
	
	import flash.display.DisplayObject;

	/**
	 * Returns a flash var from the root or the parent of the root.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 * 
	 * @root The root DisplayObject to check.
	 * @param The flash var to retrieve.
	 * 
	 * @return The value assigned to the flash variable.
	 */
	public function FlashVarUtil(root:DisplayObject, param:String):String{
		return root.loaderInfo.parameters[param] || root.parent.loaderInfo.parameters[param] || null;
	}
		
}
