package windowApplication;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.components.CButtonState;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.core.CSprite;
import temperate.docks.CRightDock;
import temperate.minimal.cursors.MHandCursor;
import temperate.minimal.MCursorManager;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFlatImageButton;
import temperate.minimal.MSeparator;
import temperate.minimal.skins.MWindowSkin;
import temperate.skins.ICWindowSkin;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;
import temperate.windows.docks.CAbsolutePopUpDock;

@:bitmap("manual-tests-src/windowApplication/arrow.png")
class Arrow extends flash.display.BitmapData { public function new() { super(0, 0); }}

@:bitmap("manual-tests-src/windowApplication/ellipse.png")
class Ellipse extends flash.display.BitmapData { public function new() { super(0, 0); }}

@:bitmap("manual-tests-src/windowApplication/figure.png")
class Figure extends flash.display.BitmapData { public function new() { super(0, 0); }}

@:bitmap("manual-tests-src/windowApplication/line.png")
class Line extends flash.display.BitmapData { public function new() { super(0, 0); }}

@:bitmap("manual-tests-src/windowApplication/pencil.png")
class Pencil extends flash.display.BitmapData { public function new() { super(0, 0); }}

@:bitmap("manual-tests-src/windowApplication/rect.png")
class Rect extends flash.display.BitmapData { public function new() { super(0, 0); }}

class ToolsWindow extends ACWindow
{
	public function new(manager:CPopUpManager) 
	{
		super(manager);
		
		_baseSkin.title = "Tools";
		
		{
			var toolBox = new CVBox();
			toolBox.gapY = 0;
			_main.add(toolBox).setPercents(100);
			
			var line = new CHBox();
			line.gapX = 0;
			toolBox.add(line).setPercents(100);
			
			var button = new MFlatImageButton();
			button.getImage(CButtonState.UP).setBitmapData(new Arrow());
			line.add(button).setPercents(100, 100);
			
			var button = new MFlatImageButton();
			button.getImage(CButtonState.UP).setBitmapData(new Ellipse());
			line.add(button).setPercents(100, 100);
			
			var line = new CHBox();
			line.gapX = 0;
			toolBox.add(line).setPercents(100);
			
			var button = new MFlatImageButton();
			button.getImage(CButtonState.UP).setBitmapData(new Figure());
			line.add(button).setPercents(100, 100);
			
			var button = new MFlatImageButton();
			button.getImage(CButtonState.UP).setBitmapData(new Line());
			line.add(button).setPercents(100, 100);
			
			var line = new CHBox();
			line.gapX = 0;
			toolBox.add(line).setPercents(100);
			
			var button = new MFlatImageButton();
			button.getImage(CButtonState.UP).setBitmapData(new Pencil());
			line.add(button).setPercents(100, 100);
			
			var button = new MFlatImageButton();
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
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Open";
		button.addEventListener(MouseEvent.CLICK, onOpenClick);
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Save";
		button.addEventListener(MouseEvent.CLICK, onSaveClick);
		_main.add(button).setPercents(100);
		
		dock = new CAbsolutePopUpDock(10, 50);
		
		MCursorManager.newHover(0).setTarget(_baseSkin.head).setValue(new MHandCursor(true));
		
		setColor(0x00ff00);
	}
	
	var _colorImage:CSprite;
	
	var _colorsWindow:ColorsWindow;
	
	function onColorClick(event:MouseEvent)
	{
		if (_colorsWindow == null)
		{
			_colorsWindow = new ColorsWindow(_manager);
		}
		_colorsWindow.open(false);
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
	
	function onOpenClick(event:MouseEvent)
	{
		var window = new OpenWindow(_manager);
		window.setSize(200, 150);
		window.open(true);
	}
	
	function onSaveClick(event:MouseEvent)
	{
		var window = new SaveWindow(_manager);
		window.open(true);
	}
	
	var _main:CVBox;
	
	override function newContainer():Sprite
	{
		_main = new CVBox();
		return _main;
	}
	
	override function newSkin():ICWindowSkin
	{
		return new MWindowSkin();
	}
}