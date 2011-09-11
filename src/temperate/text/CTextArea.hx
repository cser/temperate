package temperate.text;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.errors.Error;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import temperate.components.CScrollBar;
import temperate.components.CScrollPolicy;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.layouts.IScrollTextLayout;
import temperate.layouts.ScrollTextLayout;
import temperate.skins.ICRectSkin;

class CTextArea extends CSprite
{
	var _newHScrollBar:Void->CScrollBar;
	var _newVScrollBar:Void->CScrollBar;
	var _bgSkin:ICRectSkin;
	
	public function new(
		newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super();
		
		_newHScrollBar = newHScrollBar;
		_newVScrollBar = newVScrollBar;
		_bgSkin = bgSkin;
		
		_layout = new ScrollTextLayout();
		
		_tf = new TextField();
		_tf.multiline = true;
		_tf.addEventListener(Event.SCROLL, onTfScroll);
		_tf.addEventListener(Event.CHANGE, onTfChange);
		addChild(_tf);
		
		_bgSkin.link(addChildAt0, removeChild, graphics);
		
		_layout.hScrollPolicy = CScrollPolicy.AUTO;
		_layout.vScrollPolicy = CScrollPolicy.AUTO;
		
		_html = false;
		
		set_format(CDefaultFormatFactory.getDefaultFormat());
		
		_settedWidth = 100;
		_settedHeight = 100;
		
		_size_valid = false;
		postponeSize();
	}
	
	var _layout:IScrollTextLayout;
	var _tf:TextField;
	var _hScrollBar:CScrollBar;
	var _hScrollAvailable:Bool;
	var _vScrollBar:CScrollBar;
	var _vScrollAvailable:Bool;
	
	function showHScrollBar()
	{
		if (_hScrollBar == null)
		{
			_hScrollBar = _newHScrollBar();
			_hScrollBar.addEventListener(Event.SCROLL, onHScroll);
		}
		if (_hScrollBar.parent != this)
		{
			addChild(_hScrollBar);
			_hScrollAvailable = true;
		}
		return _hScrollBar;
	}
	
	function hideHScrollBar()
	{
		if (_hScrollBar != null && _hScrollBar.parent == this)
		{
			removeChild(_hScrollBar);
			_hScrollAvailable = false;
		}
	}
	
	function showVScrollBar()
	{
		if (_vScrollBar == null)
		{
			_vScrollBar = _newVScrollBar();
			_vScrollBar.addEventListener(Event.SCROLL, onVScroll);
		}
		if (_vScrollBar.parent != this)
		{
			addChild(_vScrollBar);
			_vScrollAvailable = true;
		}
		return _vScrollBar;
	}
	
	function hideVScrollBar()
	{
		if (_vScrollBar != null && _vScrollBar.parent == this)
		{
			removeChild(_vScrollBar);
			_vScrollAvailable = false;
		}
	}
	
	function addChildAt0(child:DisplayObject)
	{
		addChildAt(child, 0);
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_layout.isCompactWidth = isCompactWidth;
			_layout.isCompactHeight = isCompactHeight;
			_layout.width = _settedWidth;
			_layout.height = _settedHeight;
			_layout.arrange(
				_tf,
				showHScrollBar,
				hideHScrollBar,
				showVScrollBar,
				hideVScrollBar
			);
			_width = _layout.width;
			_height = _layout.height;
			
			if (_vScrollAvailable)
			{
				_vScrollBar.minValue = 1;
				_vScrollBar.maxValue = _tf.maxScrollV;
				_vScrollBar.pageSize = CMath.max(_tf.bottomScrollV - _tf.scrollV, 1);
			}
			
			if (_hScrollAvailable)
			{
				_hScrollBar.minValue = 1;
				_hScrollBar.maxValue = _tf.maxScrollH;
				_hScrollBar.pageSize = CMath.max(_tf.width, 1);
			}
			
			_view_valid = false;
		}
		if (!_view_valid)
		{
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			if (_vScrollAvailable)
			{
				_vScrollBar.x = _width - _vScrollBar.width;
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
			}
			_bgSkin.setBounds(0, 0, Std.int(_tf.width), Std.int(_tf.height));
			_bgSkin.redraw();
		}
	}
	
	function onHScroll(event:Event)
	{
		_tf.scrollH  = Std.int(_hScrollBar.value);
	}
	
	function onVScroll(event:Event)
	{
		_tf.scrollV = Std.int(_vScrollBar.value);
	}
	
	function onTfScroll(event:Event)
	{
		if (_vScrollAvailable)
		{
			_vScrollBar.value = _tf.scrollV;
		}
		if (_hScrollAvailable)
		{
			_hScrollBar.value = _tf.scrollH;
		}
	}
	
	function onTfChange(event:Event)
	{
		_size_valid = false;
		postponeSize();
	}
	
	public var type(get_type, set_type):TextFieldType;
	function get_type()
	{
		return _tf.type;
	}
	function set_type(value)
	{
		_tf.type = value;
		return value;
	}
	
	public var worldWrap(get_worldWrap, set_worldWrap):Bool;
	function get_worldWrap()
	{
		return _tf.wordWrap;
	}
	function set_worldWrap(value:Bool)
	{
		_tf.wordWrap = value;
		return value;
	}
	
	public var hScrollValue(get_hScrollValue, set_hScrollValue):Int;
	function get_hScrollValue()
	{
		return Std.int(_vScrollBar.value);
	}
	function set_hScrollValue(value:Int)
	{
		_vScrollBar.value = value;
		return value;
	}
	
	public var vScrollValue(get_vScrollValue, set_vScrollValue):Int;
	function get_vScrollValue()
	{
		return Std.int(_vScrollBar.value);
	}
	function set_vScrollValue(value:Int)
	{
		_vScrollBar.value = value;
		return value;
	}
	
	public var hMaxScrollValue(get_hMaxScrollValue, null):Int;
	function get_hMaxScrollValue()
	{
		return Std.int(_vScrollBar.maxValue);
	}
	
	public var vMaxScrollValue(get_vMaxScrollValue, null):Int;
	function get_vMaxScrollValue()
	{
		return Std.int(_vScrollBar.maxValue);
	}
	
	public var hMinScrollValue(get_hMinScrollValue, null):Int;
	function get_hMinScrollValue()
	{
		return Std.int(_vScrollBar.minValue);
	}
	
	public var vMinScrollValue(get_vMinScrollValue, null):Int;
	function get_vMinScrollValue()
	{
		return Std.int(_vScrollBar.minValue);
	}
	
	public var hScrollPolicy(get_hScrollPolicy, set_hScrollPolicy):CScrollPolicy;
	function get_hScrollPolicy()
	{
		return _layout.hScrollPolicy;
	}
	function set_hScrollPolicy(value)
	{
		_layout.hScrollPolicy = value;
		return value;
	}
	
	public var vScrollPolicy(get_vScrollPolicy, set_vScrollPolicy):CScrollPolicy;
	var _vScrollPolicy:CScrollPolicy;
	function get_vScrollPolicy()
	{
		return _layout.vScrollPolicy;
	}
	function set_vScrollPolicy(value)
	{
		_layout.vScrollPolicy = value;
		return value;
	}
	
	public var minWidth(get_minWidth, set_minWidth):Int;
	function get_minWidth()
	{
		return _layout.minWidth;
	}
	function set_minWidth(value:Int)
	{
		_layout.minWidth = value;
		_size_valid = false;
		postponeSize();
		return value;
	}
	
	public var minHeight(get_minHeight, set_minHeight):Int;
	function get_minHeight()
	{
		return _layout.minHeight;
	}
	function set_minHeight(value:Int)
	{
		_layout.minHeight = value;
		_size_valid = false;
		postponeSize();
		return value;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Text
	//
	//----------------------------------------------------------------------------------------------
	
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
			
			_size_valid = false;
			postponeSize();
		}
		return _text;
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
			
			_size_valid = false;
			postponeSize();
		}
		return _html;
	}
	
	function updateTfByText()
	{
		var settedText = _text != null ? _text : "";
		if (_html)
		{
			_tf.htmlText = settedText;
		}
		else
		{
			_tf.text = settedText;
		}
	}
	
	public var restrict(get_restrict, set_restrict):String;
	function get_restrict()
	{
		return _tf.restrict;
	}
	function set_restrict(value)
	{
		_tf.restrict = value;
		return value;
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