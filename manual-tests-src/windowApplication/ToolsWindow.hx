package windowApplication;
import flash.events.MouseEvent;
import temperate.components.CButtonState;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.core.CSprite;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFlatImageButton;
import temperate.minimal.MSeparator;
import temperate.minimal.MToolButton;
import temperate.minimal.MWindow;
import windowApplication.assets.Arrow;
import windowApplication.assets.Ellipse;
import windowApplication.assets.Figure;
import windowApplication.assets.Line;
import windowApplication.assets.Pencil;
import windowApplication.assets.Rect;

class ToolsWindow extends MWindow
{
	var _application:TestWindowApplication;
	
	public function new(application:TestWindowApplication) 
	{
		super();
		
		_application = application;
		_baseSkin.title = "Tools";
		
		{
			var toolBox = new CVBox();
			toolBox.gapY = 0;
			_main.add(toolBox).setPercents(100);
			
			var line = new CHBox();
			line.gapX = 0;
			toolBox.add(line).setPercents(100);
			
			var button = new MToolButton();
			button.getImage(CButtonState.UP).setBitmapData(new Arrow());
			line.add(button).setPercents(100, 100);
			
			var button = new MToolButton();
			button.getImage(CButtonState.UP).setBitmapData(new Ellipse());
			line.add(button).setPercents(100, 100);
			
			var line = new CHBox();
			line.gapX = 0;
			toolBox.add(line).setPercents(100);
			
			var button = new MToolButton();
			button.getImage(CButtonState.UP).setBitmapData(new Figure());
			line.add(button).setPercents(100, 100);
			
			var button = new MToolButton();
			button.getImage(CButtonState.UP).setBitmapData(new Line());
			line.add(button).setPercents(100, 100);
			
			var line = new CHBox();
			line.gapX = 0;
			toolBox.add(line).setPercents(100);
			
			var button = new MToolButton();
			button.getImage(CButtonState.UP).setBitmapData(new Pencil());
			line.add(button).setPercents(100, 100);
			
			var button = new MToolButton();
			button.getImage(CButtonState.UP).setBitmapData(new Rect());
			line.add(button).setPercents(100, 100);
		}
		
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