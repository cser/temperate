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
import temperate.skins.ICRectSkin;

class CTextArea extends CSprite
{
	var _tf:TextField;
	var _scrollBar:CScrollBar;
	var _bgSkin:ICRectSkin;
	
	public function new(scrollBar:CScrollBar, bgSkin:ICRectSkin) 
	{
		super();
		
		_tf = new TextField();
		_tf.multiline = true;
		_tf.addEventListener(Event.SCROLL, onTfScroll);
		_tf.addEventListener(Event.CHANGE, onTfChange);
		addChild(_tf);
		
		_scrollBar = scrollBar;
		_scrollBar.addEventListener(Event.SCROLL, onScroll);
		addChild(_scrollBar);
		
		_bgSkin = bgSkin;
		_bgSkin.link(addChildAt0, removeChild, graphics);
		
		_hScrollPolicy = CScrollPolicy.AUTO;
		_vScrollPolicy = CScrollPolicy.AUTO;
		
		_settedWidth = 100;
		_settedHeight = 100;
		
		_size_valid = false;
		postponeSize();
	}
	
	var _size_scrollValid:Bool;
	
	function addChildAt0(child:DisplayObject)
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
			_tf.text = text;
			
			_size_scrollValid = false;
			postponeSize();
		}
		return _text;
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = _settedWidth;
			_height = _settedHeight;
			
			_tf.width = _width;
			_tf.height = _height;
			
			_scrollBar.height = _height;
			
			_size_scrollValid = false;
			_view_valid = false;
		}
		if (!_size_scrollValid)
		{
			_size_scrollValid = true;
			
			_scrollBar.minValue = 1;
			_scrollBar.maxValue = _tf.maxScrollV;
			_scrollBar.pageSize = CMath.max(_tf.bottomScrollV, 1);
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
			
			_scrollBar.x = _width - _scrollBar.width;
			_bgSkin.setBounds(0, 0, Std.int(_width - _scrollBar.width), Std.int(_height));
			_bgSkin.redraw();
		}
	}
	
	function onScroll(event:Event)
	{
		_tf.scrollV = Std.int(_scrollBar.value);
	}
	
	function onTfScroll(event:Event)
	{
		_scrollBar.value = _tf.scrollV;
	}
	
	function onTfChange(event:Event)
	{
		_size_scrollValid = false;
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
		return Std.int(_scrollBar.value);
	}
	function set_hScrollValue(value:Int)
	{
		_scrollBar.value = value;
		return value;
	}
	
	public var vScrollValue(get_vScrollValue, set_vScrollValue):Int;
	function get_vScrollValue()
	{
		return Std.int(_scrollBar.value);
	}
	function set_vScrollValue(value:Int)
	{
		_scrollBar.value = value;
		return value;
	}
	
	public var hMaxScrollValue(get_hMaxScrollValue, null):Int;
	function get_hMaxScrollValue()
	{
		return Std.int(_scrollBar.maxValue);
	}
	
	public var vMaxScrollValue(get_vMaxScrollValue, null):Int;
	function get_vMaxScrollValue()
	{
		return Std.int(_scrollBar.maxValue);
	}
	
	public var hMinScrollValue(get_hMinScrollValue, null):Int;
	function get_hMinScrollValue()
	{
		return Std.int(_scrollBar.minValue);
	}
	
	public var vMinScrollValue(get_vMinScrollValue, null):Int;
	function get_vMinScrollValue()
	{
		return Std.int(_scrollBar.minValue);
	}
	
	public var hScrollPolicy(get_hScrollPolicy, set_hScrollPolicy):CScrollPolicy;
	var _hScrollPolicy:CScrollPolicy;
	function get_hScrollPolicy()
	{
		return _hScrollPolicy;
	}
	function set_hScrollPolicy(value)
	{
		_hScrollPolicy = value;
		return _hScrollPolicy;
	}
	
	public var vScrollPolicy(get_vScrollPolicy, set_vScrollPolicy):CScrollPolicy;
	var _vScrollPolicy:CScrollPolicy;
	function get_vScrollPolicy()
	{
		return _vScrollPolicy;
	}
	function set_vScrollPolicy(value)
	{
		_vScrollPolicy = value;
		return _vScrollPolicy;
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
/*
TODO
Починить некорректное определение размера скроллирования при изменении размеров
*/