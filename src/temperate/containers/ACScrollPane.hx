package temperate.containers;
import flash.display.DisplayObject;
import flash.events.Event;
import temperate.components.CScrollBar;
import temperate.core.CSprite;
import temperate.skins.ICRectSkin;

class ACScrollPane extends CSprite
{
	var _newHScrollBar:Void->CScrollBar;
	var _newVScrollBar:Void->CScrollBar;
	var _bgSkin:ICRectSkin;
	
	function new(newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super();
		
		_newHScrollBar = newHScrollBar;
		_newVScrollBar = newVScrollBar;
		_bgSkin = bgSkin;
		
		_bgSkin.link(addChildAt0, removeChild, graphics);
		
		_hScrollStep = 1;
		_vScrollStep = 1;
		_mouseWheelDimRatio = 1;
		
		_settedWidth = 100;
		_settedHeight = 100;
	}
	
	var _hScrollBar:CScrollBar;
	var _hScrollAvailable:Bool;
	var _vScrollBar:CScrollBar;
	var _vScrollAvailable:Bool;
	
	function showHScrollBar()
	{
		if (_hScrollBar == null)
		{
			_hScrollBar = _newHScrollBar();
			_hScrollBar.isEnabled = _isEnabled;
			_hScrollBar.step = _hScrollStep;
			_hScrollBar.updateOnMove = _updateOnMove;
			_hScrollBar.mouseWheelDimRatio = _mouseWheelDimRatio;
			_hScrollBar.addEventListener(Event.CHANGE, onHScroll);
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
			_vScrollBar.isEnabled = _isEnabled;
			_vScrollBar.step = _vScrollStep;
			_vScrollBar.updateOnMove = _updateOnMove;
			_vScrollBar.mouseWheelDimRatio = _mouseWheelDimRatio;
			_vScrollBar.addEventListener(Event.CHANGE, onVScroll);
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
			if (_vScrollBar != null)
			{
				_vScrollBar.updateOnMove = _updateOnMove;
			}
			if (_hScrollBar != null)
			{
				_hScrollBar.updateOnMove = _updateOnMove;
			}
		}
		return _updateOnMove;
	}
	
	public var hScrollStep(get_hScrollStep, set_hScrollStep):Int;
	var _hScrollStep:Int;
	function get_hScrollStep()
	{
		return _hScrollStep;
	}
	function set_hScrollStep(value:Int)
	{
		if (_hScrollStep != value)
		{
			_hScrollStep = value;
			if (_hScrollBar != null)
			{
				_hScrollBar.step = _hScrollStep;
			}
		}
		return _hScrollStep;
	}
	
	public var vScrollStep(get_vScrollStep, set_vScrollStep):Int;
	var _vScrollStep:Int;
	function get_vScrollStep()
	{
		return _vScrollStep;
	}
	function set_vScrollStep(value:Int)
	{
		if (_vScrollStep != value)
		{
			_vScrollStep = value;
			if (_vScrollBar != null)
			{
				_vScrollBar.step = _vScrollStep;
			}
		}
		return _vScrollStep;
	}
	
	function onHScroll(event:Event)
	{
	}
	
	function onVScroll(event:Event)
	{
	}
	
	public var hScrollValue(get_hScrollValue, set_hScrollValue):Int;
	function get_hScrollValue()
	{
		return 0;
	}
	function set_hScrollValue(value:Int)
	{
		return 0;
	}
	
	public var vScrollValue(get_vScrollValue, set_vScrollValue):Int;
	function get_vScrollValue()
	{
		return 0;
	}
	function set_vScrollValue(value:Int)
	{
		return 0;
	}
	
	public var hMaxScrollValue(get_hMaxScrollValue, null):Int;
	function get_hMaxScrollValue()
	{
		return 0;
	}
	
	public var vMaxScrollValue(get_vMaxScrollValue, null):Int;
	function get_vMaxScrollValue()
	{
		return 0;
	}
	
	public var hMinScrollValue(get_hMinScrollValue, null):Int;
	function get_hMinScrollValue()
	{
		return 0;
	}
	
	public var vMinScrollValue(get_vMinScrollValue, null):Int;
	function get_vMinScrollValue()
	{
		return 0;
	}
	
	public var mouseWheelDimRatio(get_mouseWheelDimRatio, set_mouseWheelDimRatio):Int;
	var _mouseWheelDimRatio:Int;
	function get_mouseWheelDimRatio()
	{
		return _mouseWheelDimRatio;
	}
	function set_mouseWheelDimRatio(value:Int)
	{
		if (_mouseWheelDimRatio != value)
		{
			_mouseWheelDimRatio = value;
			if (_hScrollAvailable)
			{
				_hScrollBar.mouseWheelDimRatio = value;
			}
			if (_vScrollAvailable)
			{
				_vScrollBar.mouseWheelDimRatio = value;
			}
		}
		return _mouseWheelDimRatio;
	}
}