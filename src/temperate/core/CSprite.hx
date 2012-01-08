package temperate.core;
import flash.display.Sprite;
import flash.events.Event;

class CSprite extends Sprite
{
	public function new() 
	{
		super();
		_validator = CValidator.getInstance();
		_isEnabled = true;
		_width = 0;
		_height = 0;
		_settedWidth = 0;
		_settedHeight = 0;
	}
	
	var _validator:CValidator;
	
	var _width:Float;
	var _height:Float;
	
	/*
	Setted sizes are restored if _inner_ content are allow it.
	Sizes _width and _height are exceed setted sizes if _inner_ content is don't fit into setted
	*/
	var _settedWidth:Float;
	var _settedHeight:Float;
	
	@:getter(width)
	function get_width():Float
	{
		validateSize();
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
		validateSize();
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
	
	var _size_valid:Bool;
	var _view_valid:Bool;
	
	inline function postponeSize():Void
	{
		_validator.postponeSize(validateSize);
	}
	
	inline function postponeView():Void
	{
		_validator.postponeView(validateView);
	}
	
	function validateSize():Void
	{
		_validator.removeSize(validateSize);
		doValidateSize();
	}
	
	function validateView():Void
	{
		_validator.removeSize(validateView);
		validateSize();
		doValidateView();
	}
	
	/**
	 * There validates all that accessible from properties
	 * It's meen, that all properties always accessed as valid
	 */
	function doValidateSize():Void
	{
		_size_valid = true;
	}
	
	/**
	 * There validates all that can't be accessible from prperties
	 * (it user see on screen only)
	 */
	function doValidateView():Void
	{
		_view_valid = true;
	}
	
	/**
	 * Call if need validate view in this moment (For draw component on BitmapData for example)
	 * Also it mast be called if components size invalidated in view validation stack
	 */
	public function validate():Void
	{
		validateView();
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