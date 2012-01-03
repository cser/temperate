package windowApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.core.CSprite;
import temperate.minimal.MScrollPane;
import temperate.minimal.MWindow;

class ImageWindow extends MWindow
{
	public function new(name:String) 
	{
		super();
		
		title = name;
		
		_skin.addHeadButton(_skin.maximizeButton).addEventListener(Event.CHANGE, onMaximizeChange);
		_skin.addHeadButton(_skin.closeButton).addEventListener(MouseEvent.CLICK, onCloseClick);
		resizable = true;
		
		_image = new CSprite();
		_pane = new MScrollPane();
		_pane.set(_image);
		_main.add(_pane).setPercents(100, 100);
	}
	
	var _pane:MScrollPane;
	var _image:CSprite;
	
	public function setImageSize(width:Int, height:Int)
	{
		_image.setSize(width, height);
		_pane.invalidate();
	}
	
	function onMaximizeChange(event:Event)
	{
		maximized = _skin.maximizeButton.selected;
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close();
	}
}