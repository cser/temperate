package temperate.minimal;
import flash.display.Sprite;
import temperate.collections.ICValueSwitcher;
import temperate.containers.CVBox;
import temperate.minimal.cursors.MResizeCursor;
import temperate.minimal.cursors.MWaitCursor;
import temperate.minimal.skins.MWindowSkin;
import temperate.minimal.windows.MWindowScaleAnimator;
import temperate.windows.ACWindow;
import temperate.windows.skins.ICWindowSkin;

class MWindow extends ACWindow
{
	public function new()
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
}