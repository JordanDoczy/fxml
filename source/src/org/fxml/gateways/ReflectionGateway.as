package org.fxml.gateways {
	import flash.utils.getDefinitionByName;

	/**
	 * Instantiates a class.
	 * 
	 * <p>This gateway is used to convert a <code>String</code> describing a <code>class</code> 
	 * into a new instance of the <code>class</code>.</p>
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.2
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class ReflectionGateway {
		
		/**
		 * Instantiates a class and returns the new object.
		 * 
		 * @param classname The class to instantiate.
		 * @param params The parameters to pass to the constructor (Array can not exceed 10 items).
		 * 
		 * @return a new instance to the class provided.
		 */
		public static function createInstance(classname:String, params:Array=null):Object{
			var ClassReference:Class;
			try{
				ClassReference = getDefinitionByName(classname) as Class;
				return buildResult(ClassReference, params);	
			}
			catch(e:Error){
				throw new Error("Can not instantiate class: \"" + classname + "\" please check you have loaded the corresponding SWF." );
			}
			return null;
		}
		
		/**
		 * @private
		 * Instantiates the class.
		 *  
		 * @classRef The class to instantiate.
		 * @params The params to pass to the constructor (Array can not exceed 10 items).
		 * 
		 * @return a new instance to the class provided.
		 */
		private static function buildResult(classRef:Class, params:Array=null):*{
			
			try{
				if(params){
					// hack to allow constructor parameters (unable to use func.apply on a constructor)
					switch(params.length){
						case 0:		return new classRef(); break;
						case 1:		return new classRef(params[0]); break;
						case 2:		return new classRef(params[0], params[1]); break;
						case 3:		return new classRef(params[0], params[1], params[2]); break;
						case 4:		return new classRef(params[0], params[1], params[2], params[3]); break;
						case 5:		return new classRef(params[0], params[1], params[2], params[3], params[4]); break;
						case 6:		return new classRef(params[0], params[1], params[2], params[3], params[4], params[5]); break;
						case 7:		return new classRef(params[0], params[1], params[2], params[3], params[4], params[5], params[6]); break;
						case 8:		return new classRef(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]); break;
						case 9:		return new classRef(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]); break;
						case 10:	return new classRef(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]); break;
						default:	return new classRef();
						}	
				}
				else{
					return new classRef();
				}
			}
			catch(e:Error){
				throw new Error("Error trying to instantiate class: " + classRef);
			}
		}
		
	}
}
