package temperate.text;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import temperate.components.CScrollBar;
import temperate.components.CScrollPolicy;
import temperate.containers.ACScrollPane;
import temperate.core.CMath;
import temperate.layouts.CScrollTextLayout;
import temperate.layouts.ICScrollTextLayout;
import temperate.skins.CSkinState;
import temperate.skins.ICRectSkin;

class CTextArea extends ACScrollPane
{
	public function new(
		newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super(newHScrollBar, newVScrollBar, bgSkin);
		
		_html = false;
		_hScrollStep = 5;
		_vScrollStep = 1;
		_editable = false;
		_updateOnMove = false;
		
		_tf = new TextField();
		_tf.multiline = true;
		_tf.addEventListener(Event.SCROLL, onTfScroll);
		_tf.addEventListener(Event.CHANGE, onTfChange);
		addChild(_tf);
		
		_layout = new CScrollTextLayout();
		_layout.tf = _tf;
		
		_layout.hScrollPolicy = CScrollPolicy.AUTO;
		_layout.vScrollPolicy = CScrollPolicy.AUTO;
		
		set_format(CDefaultFormatFactory.getDefaultFormat());
		
		updateTextType();
		updateControlsEnabled();
		
		textIndentLeft = 1;
		textIndentRight = 1;
		textIndentTop = 0;
		textIndentBottom = 0;
		
		_size_valid = false;
		postponeSize();
	}
	
	var _view_firstValid:Bool;
	
	var _layout:ICScrollTextLayout;
	var _tf:TextField;
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = isCompactWidth ? 0 : _settedWidth;
			if (_width < _layout.minWidth)
			{
				_width = _layout.minWidth;
			}
			_height = isCompactHeight ? 0 : _settedHeight;
			if (_height < _layout.minHeight)
			{
				_height = _layout.minHeight;
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
			
			_isArrangeInProcess = true;
			_layout.isCompactWidth = isCompactWidth;
			_layout.isCompactHeight = isCompactHeight;
			_layout.width = _settedWidth;
			_layout.height = _settedHeight;
			_layout.arrange(
				showHScrollBar,
				hideHScrollBar,
				showVScrollBar,
				hideVScrollBar,
				textIndentLeft + textIndentRight,
				textIndentTop + textIndentBottom,
				!_view_firstValid
			);
			_view_firstValid = true;
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
				_hScrollBar.minValue = 0;
				_hScrollBar.maxValue = _tf.maxScrollH;
				_hScrollBar.pageSize = CMath.max(_tf.width, 1);
			}
			_isArrangeInProcess = false;
			if (_vScrollAvailable)
			{
				_vScrollBar.x = _width - _vScrollBar.width;
				_vScrollBar.value = _tf.scrollV;
				_vScrollBar.validate();// Not clean, but size validated in view tick
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
				_hScrollBar.value = _tf.scrollH;
				_hScrollBar.validate();// Not clean, but size validated in view tick
			}
			
			_tf.x = textIndentLeft;
			_tf.y = textIndentTop;
			_bgSkin.setBounds(
				0,
				0,
				Std.int(_tf.width) + textIndentLeft + textIndentRight,
				Std.int(_tf.height) + textIndentTop + textIndentBottom);
			_bgSkin.redraw();
		}
	}
	
	override function onHScroll(event:Event)
	{
		_tf.scrollH = Std.int(_hScrollBar.value);
	}
	
	override function onVScroll(event:Event)
	{
		_tf.scrollV = Std.int(_vScrollBar.value);
	}
	
	var _isArrangeInProcess:Bool;
	
	function onTfScroll(event:Event)
	{
		if (_isArrangeInProcess)
		{
			return;
		}
		
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
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	function updateTextType()
	{
		_tf.type = _isEnabled && _editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
	}
	
	function updateControlsEnabled()
	{
		if (_hScrollBar != null)
		{
			_hScrollBar.isEnabled = _isEnabled;
		}
		if (_vScrollBar != null)
		{
			_vScrollBar.isEnabled = _isEnabled;
		}
		if (_isEnabled)
		{
			_bgSkin.state = _editable ? CSkinState.NORMAL : CSkinState.INACTIVE;
		}
		else
		{
			_bgSkin.state = CSkinState.DISABLED;
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
			
			_view_valid = false;
			postponeView();
		}
		return _editable;
	}
	function get_editable()
	{
		return _editable;
	}
	
	override function set_isEnabled(value)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			updateControlsEnabled();
			
			_view_valid = false;
			postponeView();
		}
		return _isEnabled;
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
	
	override function get_hScrollValue()
	{
		return _tf.scrollH;
	}
	override function set_hScrollValue(value:Int)
	{
		validate();
		_tf.scrollH = value;
		return _tf.scrollH;
	}
	
	override function get_vScrollValue()
	{
		return _tf.scrollV;
	}
	override function set_vScrollValue(value:Int)
	{
		validate();
		_tf.scrollV = value;
		return _tf.scrollV;
	}
	
	override function get_hMaxScrollValue()
	{
		return _tf.maxScrollH;
	}
	
	override function get_vMaxScrollValue()
	{
		return _tf.maxScrollV;
	}
	
	override function get_hMinScrollValue()
	{
		return 0;
	}
	
	override function get_vMinScrollValue()
	{
		return 1;
	}
	
	public var hScrollPolicy(get_hScrollPolicy, set_hScrollPolicy):CScrollPolicy;
	function get_hScrollPolicy()
	{
		return _layout.hScrollPolicy;
	}
	function set_hScrollPolicy(value)
	{
		_layout.hScrollPolicy = value;
		_view_valid = false;
		postponeView();
		return value;
	}
	
	public var vScrollPolicy(get_vScrollPolicy, set_vScrollPolicy):CScrollPolicy;
	function get_vScrollPolicy()
	{
		return _layout.vScrollPolicy;
	}
	function set_vScrollPolicy(value)
	{
		_layout.vScrollPolicy = value;
		_view_valid = false;
		postponeView();
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
	function get_text()
	{
		return _tf.text;
	}
	function set_text(value)
	{
		if (_html)
		{
			_tf.htmlText = value != null ? value : "";
		}
		else
		{
			_tf.text = value != null ? value : "";
		}
		_size_valid = false;
		postponeSize();
		dispatchEvent(new Event(Event.CHANGE));
		return value;
	}
	
	public function appendText(text:String)
	{
		if (text != null)
		{
			if (_html)
			{
				_tf.htmlText += text;
			}
			else
			{
				_tf.appendText(text);
			}
		}
		_size_valid = false;
		postponeSize();
		dispatchEvent(new Event(Event.CHANGE));
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
			if (_html)
			{
				_tf.htmlText = _tf.text;
			}
			else
			{
				_tf.text = _tf.htmlText;
			}
			_size_valid = false;
			postponeSize();
		}
		return _html;
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