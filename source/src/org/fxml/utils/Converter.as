package org.fxml.utils {

	/**
	 * Utility class for type conversion and type checking.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class Converter {
		
		/**
		 * Converts a value from <code>String</code> to a <code>Boolean</code>, <code>Number</code>, <code>null</code>, or returns the original <code>String</code>.
		 * 
		 * @param value The value to convert.
		 * 
		 * @return Possible values include <code>null</code>, <code>Boolean</code>, <code>Number</code>, or the original value (<code>String</code>) passed in.
		 */
		public static function convertValue(value:String):*{
				 if(isNull(value))		return null;
				 if(isBoolean(value)) 	return BooleanUtil(value);
			else if(isNumeric(value)) 	return NumberUtil(value);
			else						return value;
		}
		
		/**
		 * Performs a strict equality match on the value to the string "null".
		 * 
		 * @param value The value to test.
		 */
		public static function isNull(value:String):Boolean{
			return value === "null";
		}
		
		/**
		 * Determines if the value passed contains only numeric characters.
		 * 
		 * @param value The value to test.
		 */
		public static function isNumeric(value:String):Boolean{
			var reg:RegExp = /[^\d.]/g; // look for any non-digit characters (also ignore the ".") 
			return !reg.test(value);
		}
		
		/**
		 * Performs a strict equality match on the values "true" or "false".
		 * 
		 * @param value The value to test.
		 */
		public static function isBoolean(value:String):Boolean{
			return value.toLowerCase() === "true" || value.toLowerCase() === "false";
		}
		
		
		
	}
}
