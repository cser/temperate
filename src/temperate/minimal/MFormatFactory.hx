package temperate.minimal;
import temperate.text.CTextFormat;

class MFormatFactory 
{
	static var BUTTON_BASE = new CTextFormat("Tahoma", 12);
	
	public static var BUTTON_UP = BUTTON_BASE.clone()
		.setColor(0xffffee)
		;
	
	public static var BUTTON_OVER = BUTTON_BASE.clone()
		.setColor(0xffffff)
		;
	
	public static var BUTTON_DISABLED = BUTTON_BASE.clone()
		.setColor(0x305000)
		.setAlpha(.5)
		;
		
	static var LABEL_BASE = new CTextFormat("Tahoma", 12);
		
	public static var LABEL = LABEL_BASE.clone()
		;
	
	public static var LABEL_DISABLED = LABEL.clone()
		.setAlpha(.3)
		;
		
	public static var LABEL_ERROR = LABEL.clone()
		.setColor(0xa0a000);
}