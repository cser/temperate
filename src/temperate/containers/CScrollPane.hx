package temperate.containers;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import temperate.components.CScrollBar;
import temperate.components.CScrollPolicy;
import temperate.containers.ICInvalidateClient;
import temperate.core.CMath;
import temperate.core.CMouseWheelUtil;
import temperate.layouts.CScrollLayout;
import temperate.layouts.ICScrollLayout;
import temperate.layouts.parametrization.CChildWrapper;
import temperate.skins.ICRectSkin;

class CScrollPane extends ACScrollPane, implements ICInvalidateClient
{
	public function new(
		newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super(newHScrollBar, newVScrollBar, bgSkin);
		
		_scrollRect = new Rectangle();
		
		_container = new Sprite();
		addChild(_container);
		
		_layout = newScrollLayout();
		_layout.showHScrollBar = showHScrollBar;
		_layout.hideHScrollBar = hideHScrollBar;
		_layout.showVScrollBar = showVScrollBar;
		_layout.hideVScrollBar = hideVScrollBar;
		_layout.hScrollPolicy = CScrollPolicy.AUTO;
		_layout.vScrollPolicy = CScrollPolicy.AUTO;
		
		_hScrollStep = 10;
		_vScrollStep = 10;
		
		contentIndentLeft = 0;
		contentIndentRight = 0;
		contentIndentTop = 0;
		contentIndentBottom = 0;
		
		_useMouseWheel = true;
		
		updateControlsEnabled();
		
		_size_valid = false;
		postponeSize();
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
	
	function updateControlsEnabled()
	{
		updateMouseWheelEnabled();
		if (_hScrollAvailable)
		{
			_hScrollBar.isEnabled = _isEnabled;
		}
		if (_vScrollAvailable)
		{
			_vScrollBar.isEnabled = _isEnabled;
		}
	}
	
	function updateMouseWheelEnabled()
	{
		if (_isEnabled && _useMouseWheel)
		{
			_container.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		else
		{
			_container.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
	}
	
	public var useMouseWheel(get_useMouseWheel, set_useMouseWheel):Bool;
	var _useMouseWheel:Bool;
	function get_useMouseWheel()
	{
		return _useMouseWheel;
	}
	function set_useMouseWheel(value:Bool)
	{
		if (_useMouseWheel != value)
		{
			_useMouseWheel = value;
			updateMouseWheelEnabled();
		}
		return _useMouseWheel;
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		setVScrollValue(
			_vScrollValue -
			_vScrollStep * CMouseWheelUtil.getDimDelta(event.delta, _mouseWheelDimRatio));
	}
	
	var _scrollRect:Rectangle;
	var _container:Sprite;
	var _layout:ICScrollLayout;
	
	function newScrollLayout():ICScrollLayout
	{
		return new CScrollLayout();
	}
	
	var _wrapper:CChildWrapper;
	
	public var content(get_content, null):DisplayObject;
	var _content:DisplayObject;
	function get_content()
	{
		return _content;
	}
	
	public function set(value:DisplayObject):CChildWrapper
	{
		if (_content != value)
		{
			if (_content != null)
			{
				_container.removeChild(_content);
			}
			_content = value;
			if (_content != null)
			{
				_container.addChild(_content);
				_wrapper = new CChildWrapper(_content);
			}
			else
			{
				_wrapper = null;
			}
			_size_valid = false;
			postponeSize();
		}
		return _wrapper;
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_layout.wrapper = _wrapper;
			_layout.isCompactWidth = isCompactWidth;
			_layout.isCompactHeight = isCompactHeight;
			_layout.width = _settedWidth;
			_layout.height = _settedHeight;
			_layout.arrange();
			_width = _layout.width;
			_height = _layout.height;
			
			_areaWidth = Std.int(_width - (_vScrollAvailable ? _vScrollBar.width : 0));
			_areaHeight = Std.int(_height - (_hScrollAvailable ? _hScrollBar.height : 0));
			_hMaxScrollValue = CMath.intMax(Std.int(_wrapper.getWidth() - _areaWidth), 0);
			_vMaxScrollValue = CMath.intMax(Std.int(_wrapper.getHeight() - _areaHeight), 0);
			
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
			
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
				_hScrollBar.maxValue = _hMaxScrollValue;
				_hScrollBar.value = _hScrollValue;
				_hScrollBar.pageSize = _areaHeight;
				_hScrollBar.width = _areaWidth;
				_hScrollBar.validate();
			}
			if (_vScrollAvailable)
			{
				_vScrollBar.x = _width - _vScrollBar.width;
				_vScrollBar.maxValue = _vMaxScrollValue;
				_vScrollBar.value = _vScrollValue;
				_vScrollBar.pageSize = _areaWidth;
				_vScrollBar.height = _areaHeight;
				_vScrollBar.validate();
			}
			
			_scrollRect.x = _hScrollValue;
			_scrollRect.y = _vScrollValue;
			_scrollRect.width = _areaWidth;
			_scrollRect.height = _areaHeight;
			_container.scrollRect = _scrollRect;
			
			_container.x = contentIndentLeft;
			_container.y = contentIndentTop;
			_bgSkin.setBounds(
				0,
				0,
				Std.int(_areaWidth) + contentIndentLeft + contentIndentRight,
				Std.int(_areaHeight) + contentIndentTop + contentIndentBottom);
			_bgSkin.redraw();
		}
	}
	
	public var contentIndentLeft(default, null):Int;
	
	public var contentIndentRight(default, null):Int;
	
	public var contentIndentTop(default, null):Int;
	
	public var contentIndentBottom(default, null):Int;
	
	public function setContentIndents(left:Int, right:Int, top:Int, bottom:Int)
	{
		contentIndentLeft = left;
		contentIndentRight = right;
		contentIndentTop = top;
		contentIndentBottom = bottom;
		_size_valid = false;
		postponeSize();
	}
	
	override function onHScroll(event:Event)
	{
		_scrollRect.x = _hScrollBar.value;
		_container.scrollRect = _scrollRect;
	}
	
	override function onVScroll(event:Event)
	{
		_scrollRect.y = _vScrollBar.value;
		_container.scrollRect = _scrollRect;
	}
	
	/**
	 * Call it directly if content size changed
	 */
	public function invalidate()
	{
		_size_valid = false;
		postponeSize();
	}
	
	var _hScrollValue:Int;
	override function get_hScrollValue()
	{
		return _hScrollValue;
	}
	override function set_hScrollValue(value:Int)
	{
		setHScrollValue(value);
		return _hScrollValue;
	}
	
	var _vScrollValue:Int;
	override function get_vScrollValue()
	{
		return _vScrollValue;
	}
	override function set_vScrollValue(value:Int)
	{
		setVScrollValue(value);
		return _vScrollValue;
	}
	
	var _areaWidth:Int;
	var _areaHeight:Int;
	var _hMaxScrollValue:Int;
	var _vMaxScrollValue:Int;
	
	override function get_hMaxScrollValue()
	{
		return _hMaxScrollValue;
	}
	
	override function get_vMaxScrollValue()
	{
		return _vMaxScrollValue;
	}
	
	function setHScrollValue(value:Int)
	{
		_hScrollValue = value;
		if (_hScrollValue < 0)
		{
			_hScrollValue = 0;
		}
		else if (_hScrollValue > _hMaxScrollValue)
		{
			_hScrollValue = _hMaxScrollValue;
		}
		_hScrollBar.value = _hScrollValue;
		_scrollRect.x = _hScrollValue;
		_container.scrollRect = _scrollRect;
	}
	
	function setVScrollValue(value:Int)
	{
		_vScrollValue = value;
		if (_vScrollValue < 0)
		{
			_vScrollValue = 0;
		}
		else if (_vScrollValue > _vMaxScrollValue)
		{
			_vScrollValue = _vMaxScrollValue;
		}
		if (_vScrollBar != null)
		{
			_vScrollBar.value = _vScrollValue;
		}
		_scrollRect.y = _vScrollValue;
		_container.scrollRect = _scrollRect;
	}
	
	public var hScrollPolicy(get_hScrollPolicy, set_hScrollPolicy):CScrollPolicy;
	function get_hScrollPolicy()
	{
		return _layout.hScrollPolicy;
	}
	function set_hScrollPolicy(value)
	{
		_layout.hScrollPolicy = value;
		_size_valid = false;
		postponeSize();
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
		_size_valid = false;
		postponeSize();
		return value;
	}
}
/*
TODO
Проверить глушени колеса мыши
Установка значений скроллинга, в том числе вначале
Обновление при изменении контента
Обновление при девалидации
Отступы и политики размеров для контента
Отступы относительно скроллируемой области
Неактивное состояние
Изменять положение скроллирования при изменении размеров
*/