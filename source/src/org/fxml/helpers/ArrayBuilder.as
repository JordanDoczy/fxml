package org.fxml.helpers {
	
	/**
	 * Builder for Array Objects.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class ArrayBuilder extends AbstractBuilder{
		
		/**
		 * Creates an ArrayBuilder.
		 * 
		 * @builder The builder to extend from.
		 */
		public function ArrayBuilder(builder:IBuilder){
			super(builder);
		}
	
		/**
		 * Dummy method that will always return <code>true</code>.
		 * 
		 * @instance The object to check.
		 * @property The property to check.
		 * 
		 * @returns <code>true</code>
		 */
		public override function hasProperty(instance:Object, property:String):Boolean{
			instance;
			property;
			return true;
		}
		
		/**
		 * Pushes a value onto the Array.
		 * 
		 * @instance The Array to update.
		 * @property (Ignored)
		 * @value The value to push onto the Array.
		 */
		public override function setProperty(instance:Object, property:String, value:*):void{
			property;
			(instance as Array).push(value);
		}
	}
}
