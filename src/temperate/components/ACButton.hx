package temperate.components;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.components.CButtonState;
import temperate.core.CMath;
import temperate.core.CSprite;

class ACButton extends CSprite
{
	public function new() 
	{
		super();
		
		mouseEnabled = true;
		mouseChildren = false;
		
		_selected = false;
		_isDown = false;
		_isOver = false;
		_toggle = false;
		_state = CButtonState.UP;
		
		init();
		updateEnabled();
	}
	
	private var _isDown:Bool;
	
	private var _isOver:Bool;
	
	function init():Void
	{
		
	}
	
	override function set_enabled(value:Bool)
	{
		if (_enabled != value)
		{
			_enabled = value;
			updateEnabled();
		}
		return value;
	}
	
	function updateEnabled()
	{
		buttonMode = _enabled;
		if (_enabled)
		{
			removeEventListener(MouseEvent.CLICK, onBlockMouse);
			removeEventListener(MouseEvent.MOUSE_DOWN, onBlockMouse);
			removeEventListener(MouseEvent.MOUSE_UP, onBlockMouse);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		else
		{
			_isOver = false;
			_isDown = false;
			
			addEventListener(MouseEvent.CLICK, onBlockMouse, false, CMath.INT_MAX_VALUE);
			addEventListener(MouseEvent.MOUSE_DOWN, onBlockMouse, false, CMath.INT_MAX_VALUE);
			addEventListener(MouseEvent.MOUSE_UP, onBlockMouse, false, CMath.INT_MAX_VALUE);
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			if (stage != null)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			}
		}
		updateState();
	}
	
	function onBlockMouse(event:MouseEvent)
	{
		event.stopImmediatePropagation();
	}
	
	function onMouseDown(event:MouseEvent)
	{
		if (!_enabled)
		{
			event.stopImmediatePropagation();
			return;
		}
		
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		_isDown = true;
		updateState();
	}
	
	function onStageMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		if (!_enabled)
		{
			event.stopImmediatePropagation();
			return;
		}
		
		_isDown = false;
		updateState();
	}

	function onRollOver(event:MouseEvent)
	{
		_isOver = true;
		updateState();
	}
	
	function onRollOut(event:MouseEvent)
	{
		_isOver = false;
		updateState();
	}
	
	public var selected(get_selected, set_selected):Bool;
	var _selected:Bool;
	function get_selected():Bool
	{
		return _selected;
	}
	function set_selected(value:Bool)
	{
		if (_selected != value)
		{
			_selected = value;
			updateState();
		}
		return _selected;
	}
	
	public var text(get_text, set_text):String;
	var _text:String;
	function get_text():String
	{
		return _text;
	}
	function set_text(value:String)
	{
		if (_text != value)
		{
			_text = value;
			updateText();
		}
		return value;
	}
	
	function updateText()
	{
		
	}
	
	var _state:CButtonState;
	
	function updateState()
	{
		if (_enabled)
		{
			if (_isDown && _isOver)
			{
				_state = _selected ? CButtonState.DOWN_SELECTED : CButtonState.DOWN;
			}
			else if (_isDown || _isOver)
			{
				_state = _selected ? CButtonState.OVER_SELECTED : CButtonState.OVER;
			}
			else
			{
				_state = _selected ? CButtonState.UP_SELECTED : CButtonState.UP;
			}
		}
		else
		{
			_state = _selected ? CButtonState.DISABLED_SELECTED : CButtonState.DISABLED;
		}
		doUpdateState();
	}
	
	function doUpdateState()
	{
		
	}
	
	inline function getCorrectLabel(raw:String)
	{
		return raw != null && raw != "" ? raw : " ";
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
	
	public function addClickHandler(handler:MouseEvent->Dynamic)
	{
		addEventListener(MouseEvent.CLICK, handler);
		return this;
	}
	
	public function addTo(parent:DisplayObjectContainer, x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
		parent.addChild(this);
		return this;
	}
	
	public var toggle(get_toggle, set_toggle):Bool;
	var _toggle:Bool;
	function get_toggle()
	{
		return _toggle;
	}
	function set_toggle(value)
	{
		if (_toggle != value)
		{
			_toggle = value;
			if (_toggle)
			{
				addEventListener(MouseEvent.CLICK, onClick, false, CMath.INT_MAX_VALUE);
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, onClick);
			}
		}
		return _toggle;
	}
	
	function onClick(event:MouseEvent)
	{
		selected = !selected;
		dispatchEvent(new Event(Event.CHANGE));
	}
}