package org.fxml.helpers {

	/**
	 * Null Builder.
	 * 
	 * <p>Used as a base for all builders.</p>
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class NullBuilder extends AbstractBuilder {
		
		/**
		 * Creates a NullBuilder.
		 * 
		 * @param builder The builder to extend from (optional).
		 */
		public function NullBuilder(builder:IBuilder=null){
			super(builder);
		}
		
		/**
		 * Place holder for interface.
		 */
		public override function convertValue(value:XML):*{ value; return null; }

		/**
		 * Place holder for interface.
		 */
		public override function hasProperty(instance:Object, property:String):Boolean{ instance; property; return false; }

		/**
		 * Place holder for interface.
		 */
		public override function setProperty(instance:Object, property:String, value:*):void{ instance; property; value;}
	}
}
