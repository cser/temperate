package temperate.text;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import temperate.components.CScrollBar;
import temperate.core.CMath;
import temperate.core.CSprite;

class CTextArea extends CSprite
{
	var _tf:TextField;
	var _scrollBar:CScrollBar;
	
	public function new(scrollBar:CScrollBar) 
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
		
		_settedWidth = 100;
		_settedHeight = 100;
		
		_size_valid = false;
		postponeSize();
	}
	
	var _size_scrollValid:Bool;
	
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
			
			_height = _settedHeight;
			_width = _settedWidth;
			_scrollBar.height = _height;
			
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