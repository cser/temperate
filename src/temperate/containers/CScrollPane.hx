package temperate.containers;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import temperate.components.ACScrollPane;
import temperate.components.CScrollBar;
import temperate.containers.ICInvalidateClient;
import temperate.core.CMath;
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
		
		_hScrollStep = 10;
		_vScrollStep = 10;
		
		contentIndentLeft = 0;
		contentIndentRight = 0;
		contentIndentTop = 0;
		contentIndentBottom = 0;
		
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
		if (_isEnabled)
		{
			_container.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		else
		{
			_container.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		if (_hScrollAvailable)
		{
			_hScrollBar.isEnabled = _isEnabled;
		}
		if (_vScrollAvailable)
		{
			_vScrollBar.isEnabled = _isEnabled;
		}
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		var delta = event.delta;
		var sign = delta > 0 ? -1 : 1;
		setVScrollValue(
			Std.int(
				_vScrollValue +
				sign * _vScrollStep * CMath.intMax(1, Math.round(CMath.intAbs(delta) / 3))));
	}
	
	private var _scrollRect:Rectangle;
	private var _container:Sprite;
	private var _layout:ICScrollLayout;
	
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
			_layout.arrange(showHScrollBar, hideHScrollBar, showVScrollBar, hideVScrollBar);
			_width = _layout.width;
			_height = _layout.height;
			
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
			
			var areaWidth = _width - (_vScrollAvailable ? _vScrollBar.width : 0);
			var areaHeight = _height - (_hScrollAvailable ? _hScrollBar.height : 0);
			
			if (_vScrollAvailable)
			{
				_vScrollBar.x = _width - _vScrollBar.width;
				_vScrollBar.maxValue = CMath.max(_container.height - areaHeight, 0);
				_vScrollBar.value = _vScrollValue;
				_vScrollBar.pageSize = areaWidth;
				_vScrollBar.height = areaHeight;
				_vScrollBar.validate();
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
				_hScrollBar.maxValue = CMath.max(_container.width - areaWidth, 0);
				_hScrollBar.value = _hScrollValue;
				_hScrollBar.pageSize = areaHeight;
				_hScrollBar.width = areaWidth;
				_hScrollBar.validate();
			}
			
			_scrollRect.x = _hScrollValue;
			_scrollRect.y = _vScrollValue;
			_scrollRect.width = areaWidth;
			_scrollRect.height = areaHeight;
			_container.scrollRect = _scrollRect;
			
			_container.x = contentIndentLeft;
			_container.y = contentIndentTop;
			_bgSkin.setBounds(
				0,
				0,
				Std.int(areaWidth) + contentIndentLeft + contentIndentRight,
				Std.int(areaHeight) + contentIndentTop + contentIndentBottom);
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
	
	function setHScrollValue(value:Int)
	{
		_hScrollValue = value;
		_scrollRect.x = _hScrollValue;
		_container.scrollRect = _scrollRect;
	}
	
	function setVScrollValue(value:Int)
	{
		_vScrollValue = value;
		_scrollRect.y = _vScrollValue;
		_container.scrollRect = _scrollRect;
	}
}
/*
TODO
Установка значений скроллинга, в том числе вначале
Обновление при изменении контента
Обновление при девалидации
Отступы и политики размеров для контента
Отступы относительно скроллируемой области
Скроллирование колесом мыши
Неактивное состояние
*/