package windowApplication;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.components.CButtonState;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFlatImageButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MSeparator;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;
import temperate.windows.CPopUpMover;
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
		
		_main = new CVBox();
		_main.setIndents(10, 10, 10, 10);
		addChild(_main);
		
		_title = MFormatFactory.WINDOW_TITLE.newAutoSized();
		_title.text = "Tools";
		_main.add(_title);
		
		_main.add(new MSeparator(true)).setIndents( -8, -8).setPercents(100);
		
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
		
		_main.add(new MSeparator(true)).setIndents( -8, -8).setPercents(100);
		
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
		
		_size_valid = false;
		postponeSize();
		
		dock = new CAbsolutePopUpDock(10, 50);
		
		new CPopUpMover().subscribe(getManager, this, this, get_dock);
	}
	
	var _main:CVBox;
	var _buttonBox:CHBox;
	var _title:TextField;
	var _description:TextField;
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_main.width = getNeededWidth();
			_main.height = getNeededHeight();
			_width = _main.width;
			_height = _main.height;
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var g = graphics;
			g.clear();
			g.lineStyle(2, 0x000000);
			g.beginFill(0xeeeeee);
			g.drawRoundRect(0, 0, _width, _height, 10);
			g.endFill();
		}
	}
	
	function onOpenClick(event:MouseEvent)
	{
		var window = new OpenWindow(_manager);
		window.width = 200;
		window.height = 150;
		window.open(true);
	}
	
	function onSaveClick(event:MouseEvent)
	{
		new SaveWindow(_manager).open(true);
	}
	
	override function updateIsLocked() 
	{
		super.updateIsLocked();
	}
}