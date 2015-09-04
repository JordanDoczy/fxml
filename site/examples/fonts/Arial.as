package {
	import flash.display.Sprite;
	import flash.text.Font;
	 
	public class Arial extends Sprite {
		[Embed( systemFont='Arial', 
				fontFamily="Arial", 
				mimeType="application/x-font-truetype", 
				unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E', 
				embedAsCFF='false')]
		public static var arial:Class;
		Font.registerFont(arial); 
		
		[Embed( systemFont='Arial', 
				fontFamily="Arial", 
				fontWeight="bold", 
				mimeType="application/x-font-truetype", 
				unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E', 
				embedAsCFF='false')]
		public static var arialBold:Class;
		Font.registerFont(arialBold);
	}
}