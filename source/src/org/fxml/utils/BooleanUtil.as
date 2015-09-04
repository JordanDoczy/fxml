package org.fxml.utils {

	/**
	 * <code>String</code> to <code>Boolean</code> converter.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 * 
	 * @param value The value to convert.
	 */
	public function BooleanUtil(value:String=null):Boolean{
		try{
			return value.toLocaleLowerCase() === "true";
		}
		catch(e:Error){}
		
		return false;
	}
		
}
