package temperate.text;
import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.text.CTextFormat;

class CLabel extends CSprite
{
	var _size_tfValid:Bool;
	
	var _tf:TextField;
	
	public function new() 
	{
		super();
		
		_textAlignX = 0;
		_textAlignY = 0;
		_html = false;
		
		_tf = new TextField();
		_tf.selectable = false;
		_tf.autoSize = TextFieldAutoSize.LEFT;
		_tf.text = " ";
		addChild(_tf);
		
		set_format(CDefaultFormatFactory.getDefaultFormat());
	}
	
	public var format(get_format, set_format):CTextFormat;
	var _format:CTextFormat;
	function get_format()
	{
		return _format;
	}
	function set_format(value)
	{
		if (_format != value)
		{
			_format = value;
			_format.applyTo(_tf);
			_size_tfValid = false;
			_size_valid = false;
			postponeSize();
		}
		return _format;
	}
	
	public var text(get_text, set_text):String;
	var _text:String;
	function get_text()
	{
		return _text;
	}
	function set_text(value)
	{
		if (_text != value)
		{
			_text = value;
			updateTfByText();
			_size_tfValid = false;
			_size_valid = false;
			postponeSize();
		}
		return text;
	}
	
	public var html(get_html, set_html):Bool;
	var _html:Bool;
	function get_html()
	{
		return _html;
	}
	function set_html(value)
	{
		if (_html != value)
		{
			_html = value;
			updateTfByText();
			_size_tfValid = false;
			_size_valid = false;
			postponeSize();
		}
		return _html;
	}
	
	function updateTfByText()
	{
		if (_html)
		{
			if (_text != null)
			{
				_tf.htmlText = _text;
				if (_tf.text == "")
				{
					_tf.text = " ";
				}
			}
			else
			{
				_tf.text = " ";
			}
		}
		else
		{
			_tf.text = getCorrectLabel(_text);
		}
	}
	
	public var selectable(get_selectable, set_selectable):Bool;
	function get_selectable()
	{
		return _tf.selectable;
	}
	function set_selectable(value)
	{
		_tf.selectable = value;
		return value;
	}
	
	var _tfWidth:Float;
	var _tfHeight:Float;
	
	override function doValidateSize()
	{
		if (!_size_tfValid)
		{
			_size_tfValid = true;
			
			_tfWidth = _tf.width;
			_tfHeight = _tf.height;
		}
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = CMath.max(_isCompactWidth ? 0 : _settedWidth, _tfWidth);
			_height = CMath.max(_isCompactHeight ? 0 : _settedHeight, _tfHeight);
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			_tf.x = Std.int((_width - _tfWidth) * _textAlignX);
			_tf.y = Std.int((_height - _tfHeight) * _textAlignY);
		}
	}
	
	public var textAlignX(get_textAlignX, null):Float;
	var _textAlignX:Float;
	function get_textAlignX()
	{
		return _textAlignX;
	}
	
	public var textAlignY(get_textAlignY, null):Float;
	var _textAlignY:Float;
	function get_textAlignY()
	{
		return _textAlignY;
	}
	
	public function setTextAlign(alignX:Float, alignY:Float)
	{
		_textAlignX = alignX;
		_textAlignY = alignY;
		_view_valid = false;
		postponeView();
	}
	
	inline function getCorrectLabel(raw:String)
	{
		return raw != null && raw != "" ? raw : " ";
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setText(text:String)
	{
		html = false;
		this.text = text;
		return this;
	}
	
	public function setHtmlText(text:String)
	{
		html = true;
		this.text = text;
		return this;
	}
	
	public function addTo(parent:DisplayObjectContainer, x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
		parent.addChild(this);
		return this;
	}
}