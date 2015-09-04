


package com.yourdomain {
	import com.yourdomain.display.Button;
	import com.yourdomain.display.RoundedCornerButton;

	import flash.display.Sprite;

	public class ButtonMain extends Sprite {
		
		public function ButtonMain(){
			
			var button:Button = new Button();
			button.x = 10;
			button.y = 10;
			button.label = "Button Text";
			button.draw();
			addChild(button);
			
			var roundedCornerButton:Button = new RoundedCornerButton();
			roundedCornerButton.x = 100;
			roundedCornerButton.y = 10;
			roundedCornerButton.label = "Button Text";
			roundedCornerButton.draw();
			addChild(roundedCornerButton);
			
		}
	}
}


