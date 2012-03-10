package windowApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.components.CButtonSelector;
import temperate.components.CButtonState;
import temperate.components.ICButton;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.core.CSprite;
import temperate.extra.CSignal;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFlatImageButton;
import temperate.minimal.MSeparator;
import temperate.minimal.MToolButton;
import temperate.minimal.windows.AMWindow;
import windowApplication.states.ADrawState;

class ToolsWindow extends AMWindow<Dynamic>
{
	public var signalColorClick(default, null):CSignal < Void->Void > ;
	public var signalNewClick(default, null):CSignal < Void->Void > ;
	public var signalOpenClick(default, null):CSignal < Void->Void > ;
	public var signaleSaveClick(default, null):CSignal < Void->Void > ;
	public var signalFPSClick(default, null):CSignal < Void->Void > ;
	
	var _tools:CButtonSelector<ADrawState>;
	var _editorState:EditorState;
	
	public function new(
		states:Array<ADrawState>, selectedState:ADrawState, editorState:EditorState)
	{
		super();
		
		signalColorClick = new CSignal();
		signalNewClick = new CSignal();
		signalOpenClick = new CSignal();
		signaleSaveClick = new CSignal();
		signalFPSClick = new CSignal();
		
		_editorState = editorState;
		_baseSkin.title = "Tools";
		_tools = new CButtonSelector(null);
		_tools.addEventListener(Event.CHANGE, onStatesChange);
		
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
				button.getImage(CButtonState.UP).setBitmapData(state.icon);
				line.add(button);
				_tools.add(button, state);
				i++;
			}
		}
		
		_tools.value = selectedState;
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		_colorImage = new CSprite();
		_colorImage.setSize(40, 20);
		var button = new MFlatImageButton();
		button.getImage(CButtonState.UP).setImage(_colorImage);
		button.addEventListener(MouseEvent.CLICK, newListener(signalColorClick));
		_main.add(button).setPercents(100);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "New";
		button.addEventListener(MouseEvent.CLICK, newListener(signalNewClick));
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Open";
		button.addEventListener(MouseEvent.CLICK, newListener(signalOpenClick));
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Save";
		button.addEventListener(MouseEvent.CLICK, newListener(signaleSaveClick));
		_main.add(button).setPercents(100);
		saveButton = button;
		
		var button = new MFlatButton();
		button.text = "FPS";
		button.addEventListener(MouseEvent.CLICK, newListener(signalFPSClick));
		_main.add(button).setPercents(100);
		
		_editorState.colorChanged.add(onColorChange);
		onColorChange();
	}
	
	public var saveButton(default, null):ICButton;
	
	function onStatesChange(event:Event)
	{
		_editorState.tool = _tools.value;
	}
	
	var _colorImage:CSprite;
	
	function onColorChange()
	{
		var w = _colorImage.width;
		var h = _colorImage.height;
		var g = _colorImage.graphics;
		g.clear();
		g.beginFill(0x000000);
		g.drawRect(0, 0, w, h);
		g.drawRect(1, 1, w - 2, h - 2);
		g.beginFill(_editorState.color);
		g.drawRect(1, 1, w - 2, h - 2);
		g.endFill();
	}
	
	function newListener(signal:CSignal < Void->Void > )
	{
		return function (event:Event)
		{
			signal.dispatch();
		}
	}
}