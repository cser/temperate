package windowApplication;
import flash.display.Sprite;
import temperate.containers.CVBox;
import temperate.minimal.skins.MWindowSkin;
import temperate.skins.ICWindowSkin;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;

class ColorsWindow extends ACWindow
{
	public function new(manager:CPopUpManager) 
	{
		super(manager);
		
		_baseSkin.title = "Colors";
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