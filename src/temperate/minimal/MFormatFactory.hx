package temperate.minimal;
import flash.filters.GlowFilter;
import temperate.text.CTextFormat;

class MFormatFactory 
{
	static var DEFAULT_FONT:String = "Tahoma";
	
	static var BUTTON_BASE:CTextFormat = new CTextFormat(DEFAULT_FONT, 12);
	
	public static var BUTTON_UP:CTextFormat = BUTTON_BASE.clone()
		.setColor(0xffffee);
	
	public static var BUTTON_OVER:CTextFormat = BUTTON_BASE.clone()
		.setColor(0xffffff);
	
	public static var BUTTON_DISABLED:CTextFormat = BUTTON_BASE.clone()
		.setColor(0x305000)
		.setAlpha(.5);
		
	static var FLAT_BUTTON_BASE:CTextFormat = new CTextFormat(DEFAULT_FONT, 12)
		.setFilters([new GlowFilter(0x000000, .5, 6, 4)]);
	
	public static var FLAT_BUTTON_UP:CTextFormat = FLAT_BUTTON_BASE.clone()
		.setColor(0xffffee);
	
	public static var FLAT_BUTTON_OVER:CTextFormat = FLAT_BUTTON_BASE.clone()
		.setColor(0xffffff);
	
	public static var FLAT_BUTTON_DISABLED:CTextFormat = FLAT_BUTTON_BASE.clone()
		.setColor(0xffffff)
		.setAlpha(.75);
		
	static var LABEL_BASE:CTextFormat = new CTextFormat(DEFAULT_FONT, 12);
		
	public static var LABEL:CTextFormat = LABEL_BASE.clone();
	
	public static var LABEL_DISABLED:CTextFormat = LABEL.clone()
		.setAlpha(.3);
		
	public static var LABEL_ERROR:CTextFormat = LABEL.clone()
		.setColor(0xa0a000);
	
	public static var WINDOW_TITLE:CTextFormat = new CTextFormat(DEFAULT_FONT, 14)
		.setBold(true)
		.setFilters([new GlowFilter(0xffffff, .5, 4, 4, 10)]);
	public static var WINDOW_TITLE_DISABLED:CTextFormat = WINDOW_TITLE.clone().setAlpha(.7);
}