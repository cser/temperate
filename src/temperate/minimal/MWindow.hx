package temperate.minimal;
import flash.display.Sprite;
import temperate.containers.CVBox;
import temperate.minimal.skins.MWindowSkin;
import temperate.minimal.windows.MWindowScaleAnimator;
import temperate.skins.ICWindowSkin;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;

class MWindow extends ACWindow
{
	public function new(manager:CPopUpManager)
	{
		super(manager);
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
}