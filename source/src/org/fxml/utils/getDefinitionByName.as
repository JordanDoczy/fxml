package org.fxml.utils {

	import flash.utils.getDefinitionByName;

	/**
	 * Evaluates a <code>String</code> describing an object.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		24.09.2009
	 * 
	 * @private
	 * 
	 * @example "this.myTextField" returns the object myTextField on the object this.
	 */
	public function getDefinitionByName(chain:String):*{
		var array:Array = chain.split(".");
		var name:String= "";
		var object:*;
		
		for (var i:uint=0; i<array.length; i++){
			name += array[i];
			try{
				if(!object) object = flash.utils.getDefinitionByName(name);
				else return ObjectUtil.getValue(array.slice(i), object);
			}
			catch(e:Error) {}
			name += ".";
		}
		return object;	
	}
}
