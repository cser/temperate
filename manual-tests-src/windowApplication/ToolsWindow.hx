package windowApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.components.CButtonSelector;
import temperate.components.CButtonState;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.core.CSprite;
import temperate.minimal.AMWindow;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFlatImageButton;
import temperate.minimal.MSeparator;
import temperate.minimal.MToolButton;
import windowApplication.states.ADrawState;

class ToolsWindow extends AMWindow<Dynamic>
{
	var _application:TestWindowApplication;
	var _states:CButtonSelector<ADrawState>;
	
	public function new(
		application:TestWindowApplication, states:Array<ADrawState>, selectedState:ADrawState)
	{
		super();
		
		_application = application;
		_baseSkin.title = "Tools";
		_states = new CButtonSelector(null);
		_states.addEventListener(Event.CHANGE, onStatesChange);
		
		{
			var toolBox = new CVBox();
			toolBox.gapY = 0;
			_main.add(toolBox).setPercents(100);
			
			var i = 0;
			var line = null;
			var length = states.length;
			while (true)
			{
				if (i >= length)
				{
					break;
				}
				if (i % 2 == 0)
				{
					line = new CHBox();
					line.gapX = 0;
					toolBox.add(line).setPercents(100);
				}
				var state = states[i];
				var button = new MToolButton();
				button.getImage(CButtonState.UP).setBitmapData(Type.createInstance(state.icon, []));
				line.add(button);
				_states.add(button, state);
				i++;
			}
		}
		
		_states.value = selectedState;
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		_colorImage = new CSprite();
		_colorImage.setSize(40, 20);
		var button = new MFlatImageButton();
		button.getImage(CButtonState.UP).setImage(_colorImage);
		button.addEventListener(MouseEvent.CLICK, onColorClick);
		_main.add(button).setPercents(100);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "New";
		button.addEventListener(MouseEvent.CLICK, onNewClick);
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Open";
		button.addEventListener(MouseEvent.CLICK, onOpenClick);
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Save";
		button.addEventListener(MouseEvent.CLICK, onSaveClick);
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "FPS";
		button.addEventListener(MouseEvent.CLICK, onFPSClick);
		_main.add(button).setPercents(100);
		
		setColor(0x00ff00);
	}
	
	function onStatesChange(event:Event)
	{
		_application.setState(_states.value);
	}
	
	var _colorImage:CSprite;
	
	function onColorClick(event:MouseEvent)
	{
		_application.doShowColors();
	}
	
	var _color:UInt;
	function setColor(color:UInt)
	{
		if (_color != color)
		{
			_color = color;
			var w = _colorImage.width;
			var h = _colorImage.height;
			var g = _colorImage.graphics;
			g.clear();
			g.beginFill(0x000000);
			g.drawRect(0, 0, w, h);
			g.drawRect(1, 1, w - 2, h - 2);
			g.beginFill(color);
			g.drawRect(1, 1, w - 2, h - 2);
			g.endFill();
		}
	}
	
	function onNewClick(event:MouseEvent)
	{
		_application.doNew();
	}
	
	function onOpenClick(event:MouseEvent)
	{
		_application.doOpen();
	}
	
	function onSaveClick(event:MouseEvent)
	{
		_application.doSave();
	}
	
	function onFPSClick(event:MouseEvent)
	{
		_application.doShowFps();
	}
}