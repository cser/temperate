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
		
		_tf = new TextField();
		_tf.multiline = true;
		_tf.addEventListener(Event.SCROLL, onTfScroll);
		_tf.addEventListener(Event.CHANGE, onTfChange);
		addChild(_tf);
		
		_bgSkin.link(addChildAt0, removeChild, graphics);
		
		_hScrollPolicy = CScrollPolicy.AUTO;
		_vScrollPolicy = CScrollPolicy.AUTO;
		
		_settedWidth = 100;
		_settedHeight = 100;
		
		_size_valid = false;
		postponeSize();
	}
	
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
	}
	
	function hideVScrollBar()
	{
		if (_vScrollBar != null && _vScrollBar.parent == this)
		{
			removeChild(_vScrollBar);
			_vScrollAvailable = false;
		}
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
			
			_size_scrollValid = false;
			_view_valid = false;
		}
		if (!_size_scrollValid)
		{
			_size_scrollValid = true;
			
			switch (_vScrollPolicy)
			{
				case CScrollPolicy.ON:
					showVScrollBar();
				case CScrollPolicy.OFF:
					hideVScrollBar();
				case CScrollPolicy.AUTO:
					var min = 1;
					var max = _tf.maxScrollV;
					if (max > min)
					{
						showVScrollBar();
					}
					else
					{
						hideVScrollBar();
					}
			}
			
			switch (_hScrollPolicy)
			{
				case CScrollPolicy.ON:
					showHScrollBar();
				case CScrollPolicy.OFF:
					hideHScrollBar();
				case CScrollPolicy.AUTO:
					var min = 1;
					var max = _tf.maxScrollH;
					if (max > min)
					{
						showHScrollBar();
					}
					else
					{
						hideHScrollBar();
					}
			}
			
			if (_vScrollAvailable)
			{
				_vScrollBar.height = _height;
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.width = _width;
			}
			
			if (_vScrollAvailable)
			{
				_vScrollBar.minValue = 1;
				_vScrollBar.maxValue = _tf.maxScrollV;
				_vScrollBar.pageSize = CMath.max(_tf.bottomScrollV, 1);
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
				_bgSkin.setBounds(0, 0, Std.int(_width - _vScrollBar.width), Std.int(_height));
			}
			else
			{
				_bgSkin.setBounds(0, 0, Std.int(_width), Std.int(_height));
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
			}
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