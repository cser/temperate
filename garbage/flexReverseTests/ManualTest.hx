package flexReverseTests;
import flash.display.Sprite;
import flash.Lib;
import flexReverse.LayoutClient;
import flexReverse.LayoutManager;
import flexReverse.SystemManager;

class ManualTest extends Sprite
{
	function new(stage) 
	{
		super();
		
		var systemManager = new SystemManager(this, stage);
		var layoutManager = new LayoutManager(systemManager);
		
		var child = new LayoutClient(layoutManager);
		child.width = 100;
		child.height = 200;
	}
	
	static function main()
	{
		Lib.current.addChild(new ManualTest(Lib.current.stage));
	}
}