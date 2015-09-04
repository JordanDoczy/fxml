


package com.yourdomain.display {
	public class RoundedCornerButton extends Button{
		
		protected const RADIUS:uint = 8;
		
		public function RoundedCornerButton(){
			super();
		}
		
		public override function draw():void{
			graphics.beginFill(0x000000);
			
			graphics.drawRoundRect(
				0, 
				0, 
				_textField.width+PADDING+PADDING, 
				_textField.height+PADDING+PADDING, 
				RADIUS, 
				RADIUS
			);
			
			graphics.endFill();
		}
		
	}
}



