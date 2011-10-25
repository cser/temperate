package temperate.minimal;
import flash.filters.GlowFilter;
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
		
	static var FLAT_BUTTON_BASE = new CTextFormat("Tahoma", 12)
		.setFilters([new GlowFilter(0x000000, .5, 6, 4)])
		;
	
	public static var FLAT_BUTTON_UP = FLAT_BUTTON_BASE.clone()
		.setColor(0xffffee)
		;
	
	public static var FLAT_BUTTON_OVER = FLAT_BUTTON_BASE.clone()
		.setColor(0xffffff)
		;
	
	public static var FLAT_BUTTON_DISABLED = FLAT_BUTTON_BASE.clone()
		.setColor(0xffffff)
		.setAlpha(.75)
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