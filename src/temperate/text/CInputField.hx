package temperate.text;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.skins.CSkinState;
import temperate.skins.ICRectSkin;

class CInputField extends CSprite
{
	public function new(bg:ICRectSkin) 
	{
		super();
		
		_bg = bg;
		_bg.link(addChaldAt0, removeChild, graphics);
		
		_measuredTf = new TextField();
		_measuredTf.text = " ";
		_measuredTf.autoSize = TextFieldAutoSize.LEFT;
		
		_tf = new TextField();
		_tf.addEventListener(Event.CHANGE, onTfChange, false, CMath.INT_MAX_VALUE);
		addChild(_tf);
		
		_format = CDefaultFormatFactory.getDefaultFormat();
		_editable = true;
		_isCorrect = true;
		
		textIndentLeft = 1;
		textIndentRight = 1;
		textIndentTop = 0;
		textIndentBottom = 0;
		
		updateTextType();
		
		_settedWidth = 100;
		postponeSize();
	}
	
	var _size_tfMinSizeValid:Bool;
	var _view_formatValid:Bool;
	
	var _measuredTf:TextField;
	var _tf:TextField;
	var _bg:ICRectSkin;
	var _currentFormat:CTextFormat;
	
	function addChaldAt0(child:DisplayObject)
	{
		addChildAt(child, 0);
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
			_tf.text = _text != null ? _text : "";
			dispatchEvent(new Event(Event.CHANGE));
		}
		return _text;
	}
	
	function onTfChange(event:Event)
	{
		event.stopImmediatePropagation();
		event.stopPropagation();
		
		_text = _tf.text;
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	override function set_isEnabled(value)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			updateTextType();
			updateControlsEnabled();
			
			_view_formatValid = false;
			_view_valid = false;
			postponeView();
		}
		return _isEnabled;
	}
	
	function updateControlsEnabled()
	{
		if (_isEnabled)
		{
			_bg.state = _editable ? CSkinState.NORMAL : CSkinState.INACTIVE;
		}
		else
		{
			_bg.state = CSkinState.DISABLED;
		}
	}
	
	public var editable(get_editable, set_editable):Bool;
	var _editable:Bool;
	function set_editable(value)
	{
		if (value != _editable)
		{
			_editable = value;
			updateTextType();
			updateControlsEnabled();
		}
		return _editable;
	}
	function get_editable()
	{
		return _editable;
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
	
	function updateTextType()
	{
		_tf.type = _isEnabled && _editable ?
			_tf.type = TextFieldType.INPUT :
			_tf.type = TextFieldType.DYNAMIC;
	}
	
	function updateFormat()
	{
		var newFormat = null;
		if (_isEnabled)
		{
			if (_isCorrect)
			{
				newFormat = _format;
			}
			else
			{
				newFormat = _formatError;
			}
		}
		else
		{
			newFormat = _formatDisabled;
		}
		if (newFormat == null)
		{
			newFormat = _format;
		}
		if (newFormat != _currentFormat)
		{
			_currentFormat = newFormat;
			
			CTextFormat.setNullFormat(_tf);
			newFormat.applyTo(_tf);
		}
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
			
			_size_tfMinSizeValid = false;
			_size_valid = false;
			postponeSize();
			_view_formatValid = false;
			postponeView();
		}
		return _format;
	}
	
	public var formatError(get_formatError, set_formatError):CTextFormat;
	var _formatError:CTextFormat;
	function get_formatError()
	{
		return _formatError;
	}
	function set_formatError(value)
	{
		if (value != _formatError)
		{
			_formatError = value;
			
			_view_formatValid = false;
			postponeView();
		}
		return _formatError;
	}
	
	public var formatDisabled(get_formatDisabled, set_formatDisabled):CTextFormat;
	var _formatDisabled:CTextFormat;
	function get_formatDisabled()
	{
		return _formatDisabled;
	}
	function set_formatDisabled(value)
	{
		if (value != _formatDisabled)
		{
			_formatDisabled = value;
			
			_view_formatValid = false;
			postponeView();
		}
		return _formatDisabled;
	}
	
	public var isCorrect(get_isCorrect, set_isCorrect):Bool;
	var _isCorrect:Bool;
	function get_isCorrect()
	{
		return _isCorrect;
	}
	function set_isCorrect(value)
	{
		if (_isCorrect != value)
		{
			_isCorrect = value;
			
			_view_formatValid = false;
			postponeView();
		}
		return _isCorrect;
	}
	
	public var restrict(get_restrict, set_restrict):String;
	function get_restrict()
	{
		return _tf.restrict;
	}
	function set_restrict(value)
	{
		return _tf.restrict = value;
	}
	
	public var displayAsPassword(get_displayAsPassword, set_displayAsPassword):Bool;
	function get_displayAsPassword()
	{
		return _tf.displayAsPassword;
	}
	function set_displayAsPassword(value)
	{
		return _tf.displayAsPassword = value;
	}
	
	public var multiline(get_multiline, set_multiline):Bool;
	var _multiline:Bool;
	function get_multiline()
	{
		return _multiline;
	}
	function set_multiline(value)
	{
		if (_multiline != value)
		{
			_multiline = value;
			_tf.multiline = value;
			_size_valid = false;
			postponeSize();
		}
		return _multiline;
	}
	
	var _tfMinHeight:Int;
	var _tfMinWidth:Int;
	
	override function doValidateSize()
	{
		if (!_size_tfMinSizeValid)
		{
			_size_tfMinSizeValid = true;
			
			CTextFormat.setNullFormat(_measuredTf);
			_format.applyTo(_measuredTf);
			_tfMinWidth = Std.int(_measuredTf.width);
			_tfMinHeight = Std.int(_measuredTf.height);
		}
		if (!_size_valid)
		{
			_size_valid = true;
			
			var fixedWidth = _bg.getFixedWidth();
			var fixedHeight = _bg.getFixedHeight();
			_width = CMath.max3(
				_settedWidth,
				_tfMinWidth + textIndentLeft + textIndentRight,
				Math.isNaN(fixedWidth) ? 0 : fixedWidth
			);
			_height = CMath.max3(
				_multiline ? _settedHeight : 0,
				_tfMinHeight + textIndentTop + textIndentBottom,
				Math.isNaN(fixedHeight) ? 0 : fixedHeight
			);
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_formatValid)
		{
			_view_formatValid = true;
			
			updateFormat();
		}
		if (!_view_valid)
		{
			_view_valid = true;
			
			_tf.x = textIndentLeft;
			_tf.y = textIndentTop;
			_tf.width = _width - textIndentLeft - textIndentRight;
			_tf.height = _height - textIndentTop;
			_bg.setBounds(0, 0, Std.int(_width), Std.int(_height));
			_bg.redraw();
		}
	}
	
	public var textIndentLeft(default, null):Int;
	
	public var textIndentRight(default, null):Int;
	
	public var textIndentTop(default, null):Int;
	
	public var textIndentBottom(default, null):Int;
	
	public function setTextIndents(left:Int, right:Int, top:Int, bottom:Int)
	{
		textIndentLeft = left;
		textIndentRight = right;
		textIndentTop = top;
		textIndentBottom = bottom;
		_size_valid = false;
		postponeSize();
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setText(text:String)
	{
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