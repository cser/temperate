package windowApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.core.CSprite;
import temperate.minimal.MScrollPane;
import temperate.minimal.AMWindow;

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
		_pane = new MScrollPane();
		_pane.set(image);
		_main.add(_pane).setPercents(100, 100);
	}
	
	var _pane:MScrollPane;
	
	public var image(default, null):CSprite;
	
	public function setImageSize(width:Int, height:Int)
	{
		image.setSize(width, height);
		var g = image.graphics;
		g.clear();
		g.beginFill(0xffffff);
		g.drawRect(0, 0, width, height);
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