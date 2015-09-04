package {
	import flash.display.Sprite;
	import flash.text.Font;

	public class ITCAvantGardeStd extends Sprite
	{
		
		[Embed(
	    	source='../ITCAvantGardeStd/ITCAvantGardeStd-Md.otf',
	    	fontFamily="ITCAvantGardeStd",
	    	mimeType="application/x-font",
	    	unicodeRange="U+0020-U+007E,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0100-U+01FF,U+1E00-U+1EFF"
		)]
        public static var ITCAvantGardeStdMd:Class;
        Font.registerFont(ITCAvantGardeStdMd);
        
        [Embed(
	    	source='../ITCAvantGardeStd/ITCAvantGardeStd-Bold.otf',
	    	fontFamily="ITCAvantGardeStd",
	    	fontWeight="bold",
	    	mimeType="application/x-font",
	    	unicodeRange="U+0020-U+007E,U+00A1-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183,U+0100-U+01FF,U+1E00-U+1EFF"
		)]
        public static var ITCAvantGardeStdBold:Class;
        Font.registerFont(ITCAvantGardeStdBold);
	}
}