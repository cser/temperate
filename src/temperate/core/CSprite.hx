package temperate.core;
import flash.display.Sprite;
import flash.events.Event;

class CSprite extends ACValidatable
{
	public function new() 
	{
		super(CValidator.getInstance());
		_isEnabled = true;
		_width = 0;
		_height = 0;
		_settedWidth = 0;
		_settedHeight = 0;
	}
	
	var _width:Float;
	var _height:Float;
	
	/*
	Setted sizes are restored if _inner_ content are allow it.
	Sizes _width and _height are exceed setted sizes if _inner_ content is don't fit into setted
	*/
	var _settedWidth:Float;
	var _settedHeight:Float;
	
	#if nme
	
	override function nmeGetWidth():Float
	{
		__validateSize();
		return _width;
	}
	override function nmeSetWidth(value:Float):Float
	{	
		if (_settedWidth != value)
		{
			_settedWidth = value;
			_width = value;
			_size_valid = false;
			postponeSize();
		}
		return value;
	}
	
	override function nmeGetHeight():Float
	{
		__validateSize();
		return _height;
	}
	override function nmeSetHeight(value:Float):Float
	{
		if (_settedHeight != value)
		{
			_settedHeight = value;
			_height = value;
			_size_valid = false;
			postponeSize();
		}
		return value;
	}
	
	#else
	
	@:getter(width)
	function get_width():Float
	{
		__validateSize();
		return _width;
	}
	
	@:setter(width)
	function set_width(value:Float):Void
	{
		if (_settedWidth != value)
		{
			_settedWidth = value;
			_width = value;
			_size_valid = false;
			postponeSize();
		}
	}
	
	@:getter(height)
	function get_height():Float
	{
		__validateSize();
		return _height;
	}
	
	@:setter(height)
	function set_height(value:Float):Void
	{
		if (_settedHeight != value)
		{
			_settedHeight = value;
			_height = value;
			_size_valid = false;
			postponeSize();
		}
	}
	
	#end
	
	inline function postponeSize():Void
	{
		_validator.postponeSize(this);
	}
	
	inline function postponeView():Void
	{
		_validator.postponeView(this);
	}
	
	/**
	 * Call if need validate view in this moment (For draw component on BitmapData for example)
	 * Also it mast be called if components size invalidated in view validation stack
	 */
	public function validate():Void
	{
		__validateView();
	}
	
	public var isCompactWidth(get_isCompactWidth, null):Bool;
	var _isCompactWidth:Bool;
	function get_isCompactWidth()
	{
		return _isCompactWidth;
	}
	
	public var isCompactHeight(get_isCompactHeight, null):Bool;
	var _isCompactHeight:Bool;
	function get_isCompactHeight()
	{
		return _isCompactHeight;
	}
	
	public function setCompact(isCompactWidth:Bool, isCompactHeight:Bool)
	{
		_isCompactWidth = isCompactWidth;
		_isCompactHeight = isCompactHeight;
		_size_valid = false;
		postponeSize();
	}
	
	public var isEnabled(get_isEnabled, set_isEnabled):Bool;
	var _isEnabled:Bool;
	function get_isEnabled()
	{
		return _isEnabled;
	}
	function set_isEnabled(value)
	{
		_isEnabled = value;
		return _isEnabled;
	}
	
	inline function getNeededWidth():Int
	{
		return _isCompactWidth ? 0 : Std.int(_settedWidth);
	}
	
	inline function getNeededHeight():Int
	{
		return _isCompactHeight ? 0 : Std.int(_settedHeight);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function move(x:Float, y:Float):CSprite
	{
		this.x = x;
		this.y = y;
		return this;
	}
	
	public function setSize(width:Float, height:Float):CSprite
	{
		this.width = width;
		this.height = height;
		return this;
	}
}