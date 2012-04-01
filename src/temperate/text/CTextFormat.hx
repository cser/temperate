package temperate.text;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import temperate.core.CMath;

class CTextFormat extends TextFormat
{
	public function new(
		?font:String, ?size:Float, ?color:UInt, ?bold:Bool, ?italic:Bool, ?underline:Bool,
		?url:String, ?target:String, ?align:CTextFormatAlign, ?leftMargin:Float, ?rightMargin:Float,
		?indent:Float, ?leading:Float
	)
	{
		super(
			font, size, color, bold, italic, underline, url, target, align, leftMargin,
			rightMargin, indent, leading
		);
		alpha = Math.NaN;
	}
	
	public var embedFonts:Bool;
	
	public var filters:Array<Dynamic>;
	
	public function setFont(font:String, embedFonts:Bool = false):CTextFormat
	{
		this.font = font;
		this.embedFonts = embedFonts;
		return this;
	}
	
	public function setSize(size:Int):CTextFormat
	{
		this.size = size;
		return this;
	}
	
	public function setColor(color:UInt):CTextFormat
	{
		this.color = color;
		return this;
	}
	
	public function setBold(bold:Bool):CTextFormat
	{
		this.bold = bold;
		return this;
	}
	
	public function setItalic(italic:Bool):CTextFormat
	{
		this.italic = italic;
		return this;
	}
	
	public function setUnderline(underline:Bool):CTextFormat
	{
		this.underline = underline;
		return this;
	}
	
	public function setFilters(filters:Array<Dynamic>):CTextFormat
	{
		this.filters = filters;
		return this;
	}
	
	public var alpha:Float;
	
	public function setAlpha(alpha:Float):CTextFormat
	{
		this.alpha = alpha;
		return this;
	}
	
	public var colorTransform:ColorTransform;
	
	public function setColorTransform(colorTransform:ColorTransform):CTextFormat
	{
		this.colorTransform = colorTransform;
		return this;
	}
	
	public function clone():CTextFormat
	{
		var format = new CTextFormat(
			font, size, color, bold, italic, underline, url, target, align, leftMargin,
			rightMargin, indent, leading
		);
		format.blockIndent = blockIndent;
		format.bullet = bullet;
		format.display = display;
		format.kerning = kerning;
		format.letterSpacing = letterSpacing;
		format.tabStops = tabStops;
		
		format.embedFonts = embedFonts;
		format.filters = filters;
		format.alpha = alpha;
		format.colorTransform = colorTransform;
		
		return format;
	}
	
	public function applyTo(textField:TextField, shakePlainTextForNme:Bool = false):Void
	{
		textField.setTextFormat(this);
		textField.defaultTextFormat = this;
		textField.embedFonts = embedFonts;
		textField.filters = filters;
		if (colorTransform != null)
		{
			textField.transform.colorTransform = colorTransform;
			if (!Math.isNaN(alpha))
			{
				textField.alpha = alpha;
			}
		}
		else
		{
			textField.alpha = Math.isNaN(alpha) ? 1 : alpha;
		}
		#if nme
		if (shakePlainTextForNme)
		{
			textField.appendText("");
		}
		#end
	}
	
	public function newFixed(selectable:Bool = false, text:String = null):TextField
	{
		var textField:TextField = new TextField();
		textField.selectable = selectable;
		applyTo(textField);
		if (text != null)
		{
			textField.text = text;
		}
		return textField;
	}
	
	public function newAutoSized(selectable:Bool = false, text:String = null):TextField
	{
		var textField:TextField = new TextField();
		textField.autoSize = TextFieldAutoSize.LEFT;
		textField.selectable = selectable;
		applyTo(textField);
		if (text != null)
		{
			textField.text = text;
		}
		return textField;
	}
	
	public function toHtml(text:String):String
	{
		return getHtml(this, text);
	}
	
	static var _nullFormat:CTextFormat;
	
	public static function setNullFormat(tf:TextField):Void
	{
		if (_nullFormat == null)
		{
			_nullFormat = new CTextFormat();
			
			_nullFormat.align = TextFormatAlign.LEFT;
			_nullFormat.blockIndent = 0;
			_nullFormat.bold = false;
			_nullFormat.bullet = false;
			_nullFormat.color = 0x000000;
			_nullFormat.font = "Times New Roman";
			_nullFormat.indent = 0;
			_nullFormat.italic = false;
			_nullFormat.kerning = false;
			_nullFormat.leading = 0;
			_nullFormat.leftMargin = 0;
			_nullFormat.letterSpacing = 0;
			_nullFormat.rightMargin = 0;
			_nullFormat.size = 12;
			_nullFormat.tabStops = [];
			_nullFormat.target = "";
			_nullFormat.underline = false;
			_nullFormat.url = "";
			_nullFormat.colorTransform = new ColorTransform();
		}
		_nullFormat.applyTo(tf);
	}
	
	public static function getHtml(format:TextFormat, text:String):String
	{
		var fontTagText = null;
		
		if (format.font != null)
		{
			fontTagText = addToRight(fontTagText, " face=\"" + format.font + "\"");
		}
		if (format.color != null)
		{
			fontTagText = addToRight(
				fontTagText, " color=\"#" + CMath.toHex(format.color) + "\"");
		}
		if (format.size != null)
		{
			fontTagText = addToRight(fontTagText, " size=\"" + format.size + "\"");
		}
		if (format.letterSpacing != null)
		{
			fontTagText = addToRight(
				fontTagText, " letterspacing=\"" + format.letterSpacing + "\"");
		}
		if (format.kerning)
		{
			fontTagText = addToRight(fontTagText, " kerning=\"1\"");
		}
		
		var beginTags = null;
		var endTags = null;
		if (fontTagText != null)
		{
			beginTags = "<font" + fontTagText + ">";
			endTags = "</font>";
		}
		
		if (format.bold)
		{
			beginTags = addToRight(beginTags, "<b>");
			endTags = addToLeft(endTags, "</b>");
		}
		if (format.italic)
		{
			beginTags = addToRight(beginTags, "<i>");
			endTags = addToLeft(endTags, "</i>");
		}
		if (format.underline)
		{
			beginTags = addToRight(beginTags, "<u>");
			endTags = addToLeft(endTags, "</u>");
		}
		
		return beginTags == null ? text : beginTags + text + endTags;
	}
	
	static inline function addToRight(nullableText:String, additon:String):String
	{
		return nullableText != null ? nullableText + additon : additon;
	}
	
	static inline function addToLeft(nullableText:String, additon:String):String
	{
		return nullableText != null ? additon + nullableText : additon;
	}
}