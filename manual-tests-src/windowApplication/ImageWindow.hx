package windowApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.core.CSprite;
import temperate.minimal.MScrollPane;
import temperate.minimal.windows.AMWindow;

class ImageWindow extends AMWindow<Dynamic>
{
	public function new(name:String) 
	{
		super();
		
		title = name;
		
		_skin.addHeadButton(_skin.maximizeButton).addEventListener(Event.CHANGE, onMaximizeChange);
		_skin.addHeadButton(_skin.closeButton).addEventListener(MouseEvent.CLICK, onCloseClick);
		resizable = true;
		
		image = new CSprite();
		primitives = [];
		_pane = new MScrollPane();
		_pane.set(image);
		_main.add(_pane).setPercents(100, 100);
	}
	
	var _pane:MScrollPane;
	
	public var image(default, null):CSprite;
	
	public var primitives(default, null):Array<Primitive>;
	
	public function setImageSize(width:Int, height:Int)
	{
		image.setSize(width, height);
		redrawBg();
	}
	
	public function drawPrimitives(primitives:Array<Primitive>)
	{
		this.primitives = primitives;
		redrawBg();
		var g = image.graphics;
		g.lineStyle(0, 0x000000);
		for (primitive in primitives)
		{
			switch (primitive)
			{
				case MOVE_TO(x, y):
					g.moveTo(x, y);
				case LINE_TO(x, y):
					g.lineTo(x, y);
				case ELLIPSE(x, y, width, height):
					g.drawEllipse(x, y, width, height);
				case RECT(x, y, width, height):
					g.drawRect(x, y, width, height);
			}
		}
	}
	
	function redrawBg()
	{
		var g = image.graphics;
		g.clear();
		g.beginFill(0xffffff);
		g.drawRect(0, 0, image.width, image.height);
		g.endFill();
		_pane.invalidate();
	}
	
	function onMaximizeChange(event:Event)
	{
		maximized = _skin.maximizeButton.selected;
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close(null);
	}
}