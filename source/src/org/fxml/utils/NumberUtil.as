package org.fxml.utils {

	/**
	 * <code>String</code> to <code>Number</code> converter.
	 * 
	 * <p>Possible values include positive and negative whole, and floats.
	 * Use of # or 0x is also available to describe hex values. (ex: 0xFFFFFF = #FFFFFF).</p>
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 * 
	 * @param value The value to convert to a Number.
	 */
	public function NumberUtil(value:String):Number{
		
		if(value.indexOf("#") != -1) return Number(value.replace("#", "0x"));
		
		var n:Number;
		try{
			n = Number(value);
		}
		catch(e:Error){}
		
		return n;
	}
}
