package temperate.minimal.windows;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.collections.ICValueSwitcher;
import temperate.containers.CVBox;
import temperate.minimal.cursors.MResizeCursor;
import temperate.minimal.skins.MWindowSkin;
import temperate.minimal.windows.MWindowScaleAnimator;
import temperate.windows.ACWindow;
import temperate.windows.skins.ICWindowSkin;

class AMWindow< TData > extends ACWindow<TData>
{
	function new()
	{
		super();
		animator = new MWindowScaleAnimator();
	}
	
	var _skin:MWindowSkin;
	
	override function newSkin():ICWindowSkin
	{
		_skin = new MWindowSkin();
		return _skin;
	}
	
	var _main:CVBox;
	
	override function newContainer():Sprite
	{
		_main = new CVBox();
		return _main;
	}
	
	override function newResizeCursor():ICValueSwitcher<Dynamic>
	{
		return MCursorManager.newSwitcher().setValue(new MResizeCursor());
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function addCloseButton():Void
	{
		var button = _skin.closeButton;
		if (!_skin.existsHeadButton(button))
		{
			_skin.addHeadButton(button).addEventListener(MouseEvent.CLICK, onHelpedCloseClick);
		}
	}
	
	public function addMaximizeButton():Void
	{
		var button = _skin.maximizeButton;
		if (!_skin.existsHeadButton(button))
		{
			_skin.addHeadButton(button).addEventListener(Event.CHANGE, onHelpedMaximizeChange);
		}
	}
	
	function onHelpedCloseClick(event:MouseEvent)
	{
		close(null);
	}
	
	function onHelpedMaximizeChange(event:Event)
	{
		maximized = _skin.maximizeButton.selected;
	}
}