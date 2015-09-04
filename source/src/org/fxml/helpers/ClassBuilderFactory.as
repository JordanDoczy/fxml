package org.fxml.helpers {
	import org.fxml.Application;
	import org.fxml.constants.Keywords;
	import org.fxml.gateways.ReflectionGateway;
	import org.fxml.utils.BooleanUtil;
	import org.fxml.utils.ObjectUtil;
	import org.fxml.utils.getDefinitionByName;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.getQualifiedClassName;

	/**
	 * Generates objects and assigns them to the <code>target</code>.
	 * 
	 * @author		Jordan Doczy
	 * @version		2.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class ClassBuilderFactory extends EventDispatcher {
		
		/**
		 * @private
		 */
		protected var _arrayBuilder:AbstractBuilder;
		
		/**
		 * @private
		 */
		protected var _baseBuilder:AbstractBuilder;
		
		/**
		 * @private
		 */
		protected var _displayObjectContainerBuilder:AbstractBuilder;
		
		/**
		 * @private
		 */
		protected var _index:uint = 0;
		
		/**
		 * @private
		 */
		protected var _nullBuilder:AbstractBuilder;
		
		/**
		 * @private
		 */
		protected var _paused:Boolean = false;
		
		/**
		 * @private
		 */
		protected var spriteBuilder:AbstractBuilder;
		
		/**
		 * @private
		 */
		protected var _target:Application;
		
		/**
		 * @private
		 */
		protected var _XML:XML;
		
		
		
		/**
		 * Creates a ClassBuilderFactory
		 * 
		 * @param target The target to assign values to.
		 */
		public function ClassBuilderFactory(target:Application){
			_target = target;
			createBuilders();
		}
		
		/**
		 * Converts the xml into flash objects.
		 * 
		 * @param xml The XML to convert.
		 */
		public function create(xml : XML):void {
			_XML = xml;
			setProperties(xml, _target);
		}
		
		/**
		 * Pauses the parser.
		 */
		public function pause():void{
			_paused = true;
		}
		
		/**
		 * Resumes the parser.
		 */
		public function resume():void{
			_paused = false;
			setProperties(_XML, _target, _index);	
		}
		
		/**
		 * Converts an XML Node to an object.
		 * 
		 * @private
		 * 
		 * @param The XML to convert.
		 * @param builder The builder used to convert the value.
		 * @param target The target to assign the values to.
		 */
		protected function convertValue(xml:XML, builder:IBuilder=null, target:Object=null):*{
			if(xml.hasOwnProperty("@"+Keywords.CLASS)) return createClass(xml);
			else if(xml.hasOwnProperty("@"+Keywords.INSTANCE)) return retrieveInstance(xml, target);
			else if(xml.hasOwnProperty("@"+Keywords.REFERENCE)) return getDefinitionByName(xml.attribute(Keywords.REFERENCE));
			else if(xml.hasOwnProperty("@"+Keywords.FUNCTION)) return callFunction(xml, target);
			else if(builder) return builder.convertValue(xml);
		}
		
		/**
		 * Creates the builders.
		 * 
		 * @private
		 */
		protected function createBuilders():void{
			_nullBuilder   = new NullBuilder();
			_baseBuilder   = new BaseBuilder(_nullBuilder);
			_arrayBuilder  = new ArrayBuilder(_baseBuilder);
			spriteBuilder = new SpriteBuilder(_baseBuilder);
		}
		
		
		/**
		 * Retrieves a builder based on the type of instance.
		 * 
		 * @private
		 * 
		 * @param instance The instance to determine the builder type.
		 */
		protected function getBuilder(instance:*):IBuilder{
				 if(instance is Array)	return _arrayBuilder;
			else if(instance is Sprite)	return spriteBuilder;
			else						return _baseBuilder;
		}
		
		/**
		 * Sets properties on the instance.
		 * 
		 * <p>Note this is a recursive method that will step through nested XML nodes.  
		 * Parsing will continue unless the pause command is invoked. In this case the parsing
		 * will halt until the resume method is called via a delegate to an event listener.</p>
		 * 
		 * @private
		 * 
		 * @param xml The XML to parse.
		 * @param instance The instance to set properties on.
		 * @param index The child index of the XML to begin parsing at (default 0).
		 */
		protected function setProperties(xml:XML, instance:*, index:uint=0):void{
			var builder:IBuilder = getBuilder(instance);
			var child:XML;
			
			while (index < xml.children().length()){
				if(_paused) return;
			
				child = xml.children()[index];
				
				if(	builder.hasProperty(instance, child.localName()) || 
					instance is Proxy || 
					instance is Application 
				)
				{
					// call function
					if(builder.isFunction(instance, child.localName())) {
						(instance[child.localName()] as Function).apply(instance, convertValue(castAsArray(child)));
					}
					// readOnly (set child properties)
					else if(child.hasOwnProperty("@"+Keywords.READ_ONLY) && BooleanUtil(child.attribute(Keywords.READ_ONLY))){
						setProperties(child, instance[child.localName()]);
					}
					// set property on this element
					else if(child.localName() != Keywords.CONSTRUCTOR) {
						builder.setProperty(instance, child.localName(), convertValue(child, builder, getTarget(child, instance)));
					}
				}
				
				index++;
				_index = index;
			}
			
			// dispatches when XML is finished parsing
			if(xml == _XML && !_paused) dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Calls a function on the target.
		 * 
		 * @private
		 * 
		 * @param xml The xml that defines the function.
		 * @param target The target to execute the function on.
		 * 
		 * @return The result of the function.
		 */
		private function callFunction(xml:XML, target:Object):*{
			var func:Function;
			var params:Array;
				
			try{
				func = ObjectUtil.getValue(xml.attribute(Keywords.FUNCTION).toString(), target);
			}
			catch(e:Error){
				func = getDefinitionByName(xml.attribute(Keywords.FUNCTION));
			}
			
			params = (xml.length() > 0) ? convertValue(castAsArray(xml)) : [];
			
			return func.apply(target, params);
		}
		
		/**
		 * Strips out unnessarry attributes fromt the XML node and sets the class attribute to "Array".
		 * 
		 * @private
		 * 
		 * @param xml The XML to cast.
		 */
		private function castAsArray(xml:XML):XML{
			xml.@[Keywords.CLASS] = getQualifiedClassName(Array);
			delete xml.@[Keywords.FUNCTION];
			delete xml.@[Keywords.INSTANCE];
			delete xml.@[Keywords.REFERENCE];
			return xml;
		}
		
		/**
		 * Creates a new instance of a class.
		 * 
		 * @private
		 * 
		 * @param xml The XML that defines the class.
		 * 
		 * @return A instance of the class.
		 */
		private function createClass(xml:XML):*{
			var params:Array;
			var instance:*;
			
			if(xml.hasOwnProperty(Keywords.CONSTRUCTOR)) params = convertValue(castAsArray(xml.constructor[0]));
			instance =  ReflectionGateway.createInstance(xml.attribute(Keywords.CLASS), params);
			setProperties(xml, instance);
			return instance;
		}
		
		/**
		 * Retrieves a target.
		 * 
		 * <p>Depending on the type attributes defined in the XML, the target may be set to the 
		 * top level object (_target:org.fxml.Application), but will default to the target passed in.</p>
		 * 
		 * @private
		 * 
		 * @param xml The xml that defines the current object.
		 * @param target The target that is currently being created.
		 * 
		 * @return A reference to the target passed in or the <code>org.fxml.Application</code>.
		 */
		private function getTarget(xml:XML, target:Object=null):*{
				 if(xml.attribute(Keywords.FUNCTION).toString().indexOf("this") != -1) target = _target;
			else if(xml.attribute(Keywords.INSTANCE).toString().indexOf("this") != -1) target = _target;
			
			if(!target) target = _target;
			
			return target;
		}
		
		/**
		 * Retrieves a previously created instance.
		 * 
		 * @private
		 * 
		 * @param xml The XML that defines the current object.
		 * @param target The target that is currently being created.
		 */
		private function retrieveInstance(xml:XML, target:Object):*{
				
			var instance:* = ObjectUtil.getValue(xml.attribute(Keywords.INSTANCE).toString(), target);
			setProperties(xml, instance);
				
			return instance;
		}
	}
}




