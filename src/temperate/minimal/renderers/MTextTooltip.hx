package temperate.minimal.renderers;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import temperate.text.CTextFormat;
import temperate.tooltips.renderers.ACTooltip;

class MTextTooltip extends ACTooltip<String>
{
	public function new() 
	{
		super();
		
		_textBorder = 6;
		
		_bg = new MTooltipBg();
		addChild(_bg);
		
		_textField = new TextField();
		_textField.autoSize = TextFieldAutoSize.LEFT;
		_textField.selectable = false;
		addChild(_textField);
	}
	
	var _bg:MTooltipBg;
	
	public var tailIndent(get_tailIndent, set_tailIndent):Int;
	function get_tailIndent()
	{
		return _bg.tailIndent;
	}
	function set_tailIndent(value)
	{
		return _bg.tailIndent = value;
	}
	
	public var borderRadius(get_borderRadius, set_borderRadius):Int;
	function get_borderRadius()
	{
		return _bg.borderRadius;
	}
	function set_borderRadius(value)
	{
		return _bg.borderRadius = value;
	}
	
	public var borderThickness(get_borderThickness, set_borderThickness):Int;
	function get_borderThickness()
	{
		return _bg.borderThickness;
	}
	function set_borderThickness(value)
	{
		return _bg.borderThickness = value;
	}
	
	public var tailHalfWidth(get_tailHalfWidth, set_tailHalfWidth):Int;
	function get_tailHalfWidth()
	{
		return _bg.tailHalfWidth;
	}
	function set_tailHalfWidth(value)
	{
		return _bg.tailHalfWidth = value;
	}
	
	public var fillColor(get_fillColor, set_fillColor):Int;
	function get_fillColor()
	{
		return _bg.fillColor;
	}
	function set_fillColor(value)
	{
		return _bg.fillColor = value;
	}
	
	public var borderColor(get_borderColor, set_borderColor):Int;
	function get_borderColor()
	{
		return _bg.borderColor;
	}
	function set_borderColor(value)
	{
		return _bg.borderColor = value;
	}
	
	var _textField:TextField;
	
	static var _defaultFormat:CTextFormat;
	
	static function getDefaultFormat()
	{
		if (_defaultFormat == null)
		{
			_defaultFormat = new CTextFormat("Arial", 12);
		}
		return _defaultFormat;
	}
	
	public var textBorder(get_textBorder, set_textBorder):Int;
	var _textBorder:Int;
	function get_textBorder()
	{
		return _textBorder;
	}
	function set_textBorder(value)
	{
		_textBorder = value;
		return _textBorder;
	}
	
	public var format(get_format, set_format):CTextFormat;
	var _format:CTextFormat;
	function get_format()
	{
		return _format;
	}
	function set_format(value)
	{
		if (value != _format)
		{
			_format = value;
			_format.applyTo(_textField);
		}
		return _format;
	}
	
	var _data:String;
	
	override public function initData(data:String):Void
	{
		_data = data;
		
		if (_format == null)
		{
			format = getDefaultFormat();
		}
		_textField.text = _data == "" ? " " : _data;
		
		_textField.x = _textBorder;
		_textField.y = _textBorder;
		
		_width = _textField.width + textBorder * 2;
		_height = _textField.height + textBorder * 2;
		dispatchResize(Std.int(_width), Std.int(_height));
	}
	
	override public function setTailTarget(target:Rectangle):Void
	{
		_bg.redraw(_width, _height, target);
	}
}