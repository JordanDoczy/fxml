package org.fxml.helpers {
	import flash.display.Sprite;

	/**
	 * Builder for Sprites.
	 * 
	 * @author		Jordan Doczy
	 * @version		1.0.0.1
	 * @date 		15.08.2010
	 * 
	 * @private
	 */
	public class SpriteBuilder extends AbstractBuilder{

		/**
		 * @private
		 */
		protected const WIDTH:String = "width";

		/**
		 * @private
		 */
		protected const HEIGHT:String = "height";
		
		/**
		 * Creates a SpriteBuilder
		 * 
		 * @param builder The builder to extend from
		 */
		public function SpriteBuilder(builder:IBuilder){
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
			switch(property){
				case WIDTH:
					addBoundingBox(Sprite(instance), Number(value), Sprite(instance).height);
				break;
				case HEIGHT:
					addBoundingBox(Sprite(instance), Sprite(instance).width, Number(value));
				break;
				default: _builder.setProperty(instance, property, value);
			}
		}
		
		/**
		 * Creates a rectangle on the graphics property.
		 * 
		 * @private
		 * 
		 * @instance The Sprite to be accessed.
		 * @width The width of the box to draw.
		 * @height The height of the box to draw.
		 */
		protected function addBoundingBox(instance:Sprite, width:Number, height:Number):void{
			instance.graphics.beginFill(0x000000, 0);
			instance.graphics.drawRect(0, 0, width, height);
			instance.graphics.endFill();
		}
	}
}
