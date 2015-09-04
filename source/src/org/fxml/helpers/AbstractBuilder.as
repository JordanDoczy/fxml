package org.fxml.helpers {

	/**
	 * Template Builder class.
	 * 
	 * <p>Wrapper class for Builders.</p>
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */	 
	public class AbstractBuilder implements IBuilder {
		
		/**
		 * @private
		 */
		protected var _builder:IBuilder;
		
		/**
		 * Creates an Abstract Builder.
		 * 
		 * @param builder The IBuilder to invoke.
		 */
		public function AbstractBuilder(builder:IBuilder=null){
			if(builder) _builder = builder;
		}
		
		/**
		 * A wrapper method that invokes the <code>convertValue</code> method on the concrete builder.
		 * 
		 * @param value the XML to convert.
		 * 
		 * @return A object of any type.
		 */
		public function convertValue(value:XML):*{
			if(_builder) return _builder.convertValue(value);
			return null;
		}
		
		/**
		 * A wrapper method that invokes the <code>hasProperty</code> method on the concrete builder.
		 * 
		 * @param instance The object to check.
		 * @param property The property to check.
		 */
		public function hasProperty(instance:Object, property:String):Boolean{
			if(_builder) return _builder.hasProperty(instance, property);
			return false;
		}
		
		/**
		 * A wrapper method that invokes the <code>isFunction</code> method on the concrete builder.
		 * 
		 * @param instance The object to check.
		 * @param property The property to check.
		 */
		public function isFunction(instance:Object, property:String):Boolean{
			if(_builder) return _builder.isFunction(instance, property);
			return false;
		}
		
		/**
		 * A wrapper method that invokes the <code>setProperty</code> method on the concrete builder.
		 * 
		 * @param instance The object to update.
		 * @param property The property to set.
		 * @param value The value to set the property to.
		 */
		public function setProperty(instance:Object, property:String, value:*):void{
			if(_builder) _builder.setProperty(instance, property, value);
		}
	}
}
