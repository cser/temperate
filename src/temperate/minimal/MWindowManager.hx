package temperate.minimal;
import flash.display.Stage;
import flash.events.Event;
import flash.Lib;
import temperate.minimal.windows.MLockArea;
import temperate.windows.CWindowManager;
import temperate.windows.ICWindow;

class MWindowManager
{
	static var _instance:CWindowManager;
	
	static function getInstance():CWindowManager
	{
		if (_instance == null)
		{
			_stage = Lib.current.stage;
			_instance = new CWindowManager(_stage);
			_lockArea = new MLockArea().setManager(_instance);
			_stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize();
		}
		return _instance;
	}
	
	public static function add(popUp:ICWindow, modal:Bool, fast:Bool = false):Void
	{
		getInstance().add(popUp, modal, fast);
		var index = _stage.getChildIndex(_instance.getWindowAt(0).view);
		var lockView = _lockArea.container;
		if (lockView.parent != _stage)
		{
			_stage.addChildAt(_lockArea, index);
		}
		else
		{
			var lockIndex = _stage.getChildIndex(lockView);
			if (lockIndex > index)
			{
				_stage.setChildIndex(_lockArea, index);
			}
		}
	}
	
	public static function moveToTop(popUp:ICWindow):Void
	{
		getInstance().moveToTop(popUp);
	}
	
	public static function moveTo(popUp:ICWindow, index:Int):Void
	{
		getInstance().moveTo(popUp, index);
	}
	
	public static function remove(popUp:ICWindow, fast:Bool = false):Void
	{
		getInstance().remove(popUp, fast);
	}
	
	static var _stage:Stage;
	static var _lockArea:MLockArea;
	
	static function onStageResize(event:Event = null)
	{
		_instance.setArea(0, 0, Std.int(_stage.stageWidth), Std.int(_stage.stageHeight));
		_lockArea.setArea(
			_instance.areaX, _instance.areaY, _instance.areaWidth, _instance.areaHeight);
	}
}