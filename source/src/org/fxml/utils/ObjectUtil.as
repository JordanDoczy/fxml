package org.fxml.utils {
	import org.fxml.IObject;

	import mx.utils.DescribeTypeCache;

	import flash.display.DisplayObjectContainer;
	import flash.utils.Proxy;

	/**
	 * Utility class.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.9
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class ObjectUtil {
		
		/**
		 * Retrives a value from an object.
		 * 
		 * <p>Retrieves values from objects from a string representation.
		 * For example: a chain of "myTextField.text", on the object <code>this</code> would return 
		 * the following: <code>this.myTextField.text</code>. Bracket notation may also be used.
		 * Example: a chain of "myTextField['text']" on the object <code>this</code> would return the 
		 * same result. Since the method is recursive, multiple levels may be accessed 
		 * (example: "mySprite.myChildSprite.myTextField", etc.).</p>
		 * 
		 * @param chain A <code>String</code> or <code>Array</code> describing an object.
		 * @param object A object to retrieve the <code>chain</code> from.
		 * 
		 * @return The result of the <code>chain</code> on the <code>object</code>.
		 */
		public static function getValue(chain:*, object:*):*{
			try{
				if(chain == "this") return object;
				if(chain is String){
					chain = String(chain).replace("[", ".");
					chain = String(chain).replace("]", "");	
					chain = String(chain).split("."); // convert chain to Array
				}
				if(chain[0] == "this") return getValue((chain as Array).slice(1), object);
				
				var property:*; 
				
				if(object is Proxy || Object(object).hasOwnProperty(chain[0])){
					property = object[chain[0]];
				}
				else if(object is IObject && IObject(object).hasProperty(chain[0])){
					property = IObject(object).getProperty(chain[0]);
				}
				else if(object is DisplayObjectContainer){
					try{
						property = DisplayObjectContainer(object).getChildByName(chain[0]);
					}
					catch(e:Error){}
				}
				
				if(chain is Array && (chain as Array).length > 1) return getValue((chain as Array).slice(1), property);
				else return property;
			}
			catch(e:Error){
				throw new Error("can not fetch property: " + chain + " on object " + object);
			}
		}
		
		/**
		 * Determines if an object is created from a <code>dynamic</code> class.
		 * 
		 * @return <code>true</code> if the object is <code>dynamic</code>; otherwise <code>false</code>.
		 */
		public static function isDynamic(object:*):Boolean {
		    var type:XML = DescribeTypeCache.describeType(object).typeDescription;
		    if(type["isDynamic"]) return true;
		    return false;
		}
		
	}
}