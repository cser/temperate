package temperate.text;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import temperate.components.CScrollBar;
import temperate.components.CScrollPolicy;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.layouts.IScrollTextLayout;
import temperate.layouts.ScrollTextLayout;
import temperate.skins.CSkinState;
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
		
		_html = false;
		_hLineScrollSize = 5;
		_editable = false;
		_updateOnMove = false;
		
		_tf = new TextField();
		_tf.multiline = true;
		_tf.addEventListener(Event.SCROLL, onTfScroll);
		_tf.addEventListener(Event.CHANGE, onTfChange);
		addChild(_tf);
		
		_layout = new ScrollTextLayout();
		_layout.tf = _tf;
		
		_bgSkin.link(addChildAt0, removeChild, graphics);
		
		_layout.hScrollPolicy = CScrollPolicy.AUTO;
		_layout.vScrollPolicy = CScrollPolicy.AUTO;
		
		set_format(CDefaultFormatFactory.getDefaultFormat());
		
		updateTextType();
		updateControlsEnabled();
		
		textIndentLeft = 1;
		textIndentRight = 1;
		textIndentTop = 0;
		textIndentBottom = 0;
		
		_settedWidth = 100;
		_settedHeight = 100;
		
		_size_valid = false;
		postponeSize();
	}
	
	var _view_firstValid:Bool;
	
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
			_hScrollBar.enabled = _enabled;
			_hScrollBar.lineScrollSize = _hLineScrollSize;
			_hScrollBar.updateOnMove = _updateOnMove;
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
			_vScrollBar.enabled = _enabled;
			_vScrollBar.updateOnMove = _updateOnMove;
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
				_vScrollBar.initValue(_tf.scrollV);
				_vScrollBar.validate();// Not clean, but size validated in view tick
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
				_hScrollBar.initValue(_tf.scrollH);
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
	
	function onHScroll(event:Event)
	{
		_tf.scrollH = Std.int(_hScrollBar.value);
	}
	
	function onVScroll(event:Event)
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
			_vScrollBar.initValue(_tf.scrollV);
		}
		if (_hScrollAvailable)
		{
			_hScrollBar.initValue(_tf.scrollH);
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
		_tf.type = _enabled && _editable ?
			_tf.type = TextFieldType.INPUT :
			_tf.type = TextFieldType.DYNAMIC;
	}
	
	function updateControlsEnabled()
	{
		if (_vScrollBar != null)
		{
			_vScrollBar.enabled = _enabled;
		}
		if (_hScrollBar != null)
		{
			_hScrollBar.enabled = _enabled;
		}
		if (_enabled)
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
		}
		return _editable;
	}
	function get_editable()
	{
		return _editable;
	}
	
	override function set_enabled(value)
	{
		if (_enabled != value)
		{
			_enabled = value;
			updateControlsEnabled();
			
			_view_valid = false;
			postponeView();
		}
		return _enabled;
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
	
	public var hLineScrollSize(get_hLineScrollSize, set_hLineScrollSize):Int;
	var _hLineScrollSize:Int;
	function get_hLineScrollSize()
	{
		return _hLineScrollSize;
	}
	function set_hLineScrollSize(value:Int)
	{
		if (_hLineScrollSize != value)
		{
			_hLineScrollSize = value;
			if (_hScrollBar != null)
			{
				_hScrollBar.lineScrollSize = _hLineScrollSize;
			}
		}
		return _hLineScrollSize;
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
	
	public var updateOnMove(get_updateOnMove, set_updateOnMove):Bool;
	var _updateOnMove:Bool;
	function get_updateOnMove()
	{
		return _updateOnMove;
	}
	function set_updateOnMove(value:Bool)
	{
		if (_updateOnMove != value)
		{
			_updateOnMove = value;
			if (_vScrollAvailable)
			{
				_vScrollBar.updateOnMove = _updateOnMove;
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.updateOnMove = _updateOnMove;
			}
		}
		return _updateOnMove;
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
			dispatchEvent(new Event(Event.CHANGE));
		}
		return _text;
	}
	
	public function appendText(text:String)
	{
		_text += _text != null ? _text + text : text;
		if (_html)
		{
			_tf.htmlText = _text != null ? _text : "";
		}
		else
		{
			if (text != null)
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