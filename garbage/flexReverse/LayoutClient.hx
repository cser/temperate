package flexReverse;
import flash.display.Sprite;
import flash.display.DisplayObject;

class LayoutClient extends Sprite, implements ILayoutManagerClient
{
	public function new(layoutManager:LayoutManager) 
	{
		super();
		displayObject = this;
		_layoutManager = layoutManager;
		_initialized = false;
		_nestLevel = 0;
	}
	
	public var displayObject(default, null):DisplayObject;
	
	var _layoutManager:LayoutManager;
	
	var _width:Float;
	var _height:Float;
	
	@:getter(width)
	function get_width():Float
	{
		validateSize();
		return _width;
	}
	
	@:setter(width)
	function set_width(value:Float):Void
	{
		_width = value;
		invalidateSize();
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
		_height = value;
		invalidateSize();
	}
	
	var _isPropertiesValid:Bool;
	var _isSizeValid:Bool;
	var _isViewValid:Bool;
	
	inline function invalidateSize()
	{
		_isSizeValid = false;
		_layoutManager.invalidateSize(this);
	}
	
	inline function invalidateView()
	{
		_isViewValid = false;
		_layoutManager.invalidateDisplayList(this);
	}
	
	inline function invalidateProperties()
	{
		_isPropertiesValid = false;
		_layoutManager.invalidateProperties(this);
	}
	
	public var isCompactWidth(default, null):Bool;
	
	public var isCompactHeight(default, null):Bool;
	
	public function setCompact(isCompactWidth:Bool, isCompactHeight:Bool)
	{
		this.isCompactWidth = isCompactWidth;
		this.isCompactHeight = isCompactHeight;
		invalidateSize();
	}
	
	public var initialized(get_initialized, set_initialized):Bool;
	var _initialized:Bool;
	function get_initialized()
	{
		return _initialized;
	}
	function set_initialized(value)
	{
		_initialized = value;
		return _initialized;
	}
	
	public var nestLevel(get_nestLevel, set_nestLevel):Int;
	private var _nestLevel:Int;
	function get_nestLevel()
	{
		return _nestLevel;
	}
	function set_nestLevel(value)
	{
		_nestLevel = value;
		return _nestLevel;
	}
	
    public var processedDescriptors(get_processedDescriptors, set_processedDescriptors):Bool;
	var _processedDescriptors:Bool;
	function get_processedDescriptors()
	{
		return _processedDescriptors;
	}
	function set_processedDescriptors(value)
	{
		_processedDescriptors = value;
		return _processedDescriptors;
	}
	
	public var updateCompletePendingFlag(
		get_updateCompletePendingFlag, set_updateCompletePendingFlag):Bool;
	var _updateCompletePendingFlag:Bool;
	function get_updateCompletePendingFlag()
	{
		return _updateCompletePendingFlag;
	}
	function set_updateCompletePendingFlag(value)
	{
		_updateCompletePendingFlag = value;
		return _updateCompletePendingFlag;
	}

	public function validateProperties():Void
	{
	}
    
    public function validateSize(recursive:Bool = false):Void
	{
	}
    
    public function validateDisplayList():Void
	{
	}
}