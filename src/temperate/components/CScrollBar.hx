package temperate.components;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.skins.ICRectSkin;

class CScrollBar extends CSprite
{
	var _horizontal:Bool;
	var _leftArrow:ACButton;
	var _rightArrow:ACButton;
	var _thumb:ACButton;
	var _bg:ICRectSkin;
	
	public function new(
		horizontal:Bool, leftArrow:ACButton, rightArrow:ACButton, thumb:ACButton, bg:ICRectSkin
	) 
	{
		super();
		
		_horizontal = horizontal;
		_leftArrow = leftArrow;
		_rightArrow = rightArrow;
		_thumb = thumb;
		_bg = bg;
		
		_minValue = 0;
		_maxValue = 100;
		_value = 0;
		
		init();
		
		_settedWidth = _horizontal ? 100 : 0;
		_settedHeight = _horizontal ? 0 : 100;
		postponeSize();
	}
	
	function init()
	{
		_bg.link(addChild, removeChild, graphics);
		addChild(_thumb);
		addChild(_leftArrow);
		addChild(_rightArrow);
		
		_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
	}
	
	function onThumbMouseDown(event:MouseEvent)
	{
		_thumb.startDrag(
			false,
			_horizontal ? 
				new Rectangle(_guideLeft, _guideTop, _guideSize - _thumb.width, 0) :
				new Rectangle(_guideTop, _guideLeft, 0, _guideSize - _thumb.height)
		);
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
	}
	
	function onStageMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		_thumb.stopDrag();
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			updateSize();
			updateBaseArrange();
			setThumbPositionByValue();
		}
	}
	
	function updateSize()
	{
		var minWidth;
		var minHeight;
		if (_horizontal)
		{
			minWidth = _leftArrow.width + _rightArrow.width;
			minHeight = CMath.max3(_leftArrow.height, _rightArrow.height, _thumb.height);
		}
		else
		{
			minWidth = CMath.max3(_leftArrow.width, _rightArrow.width, _thumb.width);
			minHeight = _leftArrow.height + _rightArrow.height;
		}
		if (_horizontal)
		{
			_width = _isCompactWidth ? minWidth : _settedWidth;
			_height = minHeight;
		}
		else
		{
			_width = minWidth;
			_height = _isCompactHeight ? minHeight : _settedHeight;
		}
	}
	
	var _guideLeft:Float;
	var _guideTop:Float;
	var _guideSize:Float;
	
	function updateBaseArrange()
	{
		if (_horizontal)
		{
			_leftArrow.x = 0;
			_leftArrow.y = 0;
			_rightArrow.x = _width - _rightArrow.width;
			_rightArrow.y = 0;
		}
		else
		{
			_leftArrow.x = 0;
			_leftArrow.y = 0;
			_rightArrow.x = 0;
			_rightArrow.y = _height - _rightArrow.height;
		}
		
		_guideLeft = _horizontal ? _leftArrow.width : 0;
		_guideTop = _horizontal ? 0 : _leftArrow.width;
		_guideSize = _horizontal ?
			_width - _leftArrow.width - _rightArrow.width :
			_height - _leftArrow.height - _rightArrow.height;
	}
	
	function setThumbPositionByValue()
	{
		var offset:Int = Std.int(_guideLeft + _guideSize * _value / (_maxValue - _minValue));
		if (_horizontal)
		{
			_thumb.x = offset;
			_thumb.y = _guideTop;
		}
		else
		{
			_thumb.x = _guideTop;
			_thumb.y = offset;
		}
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parameters
	//
	//----------------------------------------------------------------------------------------------
	
	public var value(get_value, set_value):Float;
	var _value:Float;
	function get_value()
	{
		return _value;
	}
	function set_value(value)
	{
		_value = value;
		return _value;
	}
	
	public var minValue(get_minValue, set_minValue):Float;
	var _minValue:Float;
	function get_minValue()
	{
		return _minValue;
	}
	function set_minValue(value)
	{
		_minValue = value;
		return _minValue;
	}
	
	public var maxValue(get_maxValue, set_maxValue):Float;
	var _maxValue:Float;
	function get_maxValue()
	{
		return _maxValue;
	}
	function set_maxValue(value)
	{
		_maxValue = value;
		return _maxValue;
	}
	
	public var pageSize(get_pageSize, set_pageSize):Float;
	var _pageSize:Float;
	function get_pageSize()
	{
		return _pageSize;
	}
	function set_pageSize(value)
	{
		_pageSize = value;
		return _pageSize;
	}
	
	public var pageScrollSize(get_pageScrollSize, set_pageScrollSize):Float;
	var _pageScrollSize:Float;
	function get_pageScrollSize()
	{
		return _pageScrollSize;
	}
	function set_pageScrollSize(value)
	{
		_pageScrollSize = value;
		return _pageScrollSize;
	}
	
	public var lineScrollSize(get_lineScrollSize, set_lineScrollSize):Float;
	var _lineScrollSize:Float;
	function get_lineScrollSize()
	{
		return _lineScrollSize;
	}
	function set_lineScrollSize(value)
	{
		_lineScrollSize = value;
		return _lineScrollSize;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setValues(minValue:Int, maxValue:Int = CMath.INT_MAX_VALUE, value:Int = 0)
	{
		this.minValue = minValue;
		this.maxValue = maxValue;
		this.value = value;
		return this;
	}
	
	public function addChangeHandler(handler:Event->Dynamic)
	{
		addEventListener(Event.CHANGE, handler);
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