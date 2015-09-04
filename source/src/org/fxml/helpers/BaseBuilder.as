package org.fxml.helpers {
	import org.fxml.IObject;
	import org.fxml.utils.Converter;
	import org.fxml.utils.ObjectUtil;
	import org.fxml.utils.getClassName;

	import flash.utils.Proxy;

	/**
	 * Builder for Generic Objects.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.5
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class BaseBuilder extends AbstractBuilder{
		
		/**
		 * Creates a BaseBuilder.
		 * 
		 * @builder The builder to extend from.
		 */
		public function BaseBuilder(builder:IBuilder){
			super(builder);
		}
		
		/**
		 * Sets a property on the object.
		 * 
		 * @instance The object to be updated.
		 * @property The property to be set.
		 * @value The value to be assigned to the property.
		 */
		public override function setProperty(instance:Object, property:String, value:*):void{
			try{
				if(instance is IObject) IObject(instance).setProperty(property, value);
				else instance[property] = value;
			}
			catch(e:Error){
				throw new Error("property: " + property + " not found on object: " + getClassName(instance));
			}
		}
		
		/**
		 * Determins if the property exists on the object.
		 * 
		 * @instance The object to be checked.
		 * @property The property to be checked.
		 */
		public override function hasProperty(instance:Object, property:String):Boolean{
			
			if(instance is Proxy)					 return true; 
			else if(instance is IObject)			 return IObject(instance).hasProperty(property);
			else if (ObjectUtil.isDynamic(instance)) return true;
			else									 return instance.hasOwnProperty(property);
		}
		
		/**
		 * Determins if the property is a method.
		 * 
		 * @instance The object to be checked.
		 * @property The property to be checked.
		 */
		public override function isFunction(instance:Object, property:String):Boolean{
			if(instance is Proxy){
				try{
					return instance[property] is Function;
				}
				catch(e:Error){}
				return false;
			}
			else if(instance.hasOwnProperty(property))	return instance[property] is Function;
			else 										return false;
		}
		
		/**
		 * Converts the XML into a value.
		 * 
		 * @value The XML to convert.
		 * 
		 * @return The result of converting the value (<code>Boolean</code>, <code>Number</code>, or <code>String</code>).
		 */
		public override function convertValue(value:XML):*{
			return Converter.convertValue(value.toString());
		}
	}
}
