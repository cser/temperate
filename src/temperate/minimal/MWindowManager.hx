package temperate.minimal;
import flash.display.Stage;
import flash.events.Event;
import flash.Lib;
import temperate.minimal.windows.MLockArea;
import temperate.windows.CWindowManager;
import temperate.windows.ICWindow;

class MWindowManager
{
	static var _manager:CWindowManager;
	
	static function getManager():CWindowManager
	{
		if (_manager == null)
		{
			_stage = Lib.current.stage;
			_manager = new CWindowManager(_stage);
			_manager.keyboardDispatcher = _stage;
			_lockArea = new MLockArea().setManager(_manager);
			_stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize();
		}
		return _manager;
	}
	
	public static function add(popUp:ICWindow, modal:Bool, fast:Bool = false):Void
	{
		getManager().add(popUp, modal, fast);
		var index = _stage.getChildIndex(_manager.getWindowAt(0).view);
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
		getManager().moveToTop(popUp);
	}
	
	public static function moveTo(popUp:ICWindow, index:Int):Void
	{
		getManager().moveTo(popUp, index);
	}
	
	public static function remove(popUp:ICWindow, fast:Bool = false):Void
	{
		getManager().remove(popUp, fast);
	}
	
	static var _stage:Stage;
	static var _lockArea:MLockArea;
	
	static function onStageResize(event:Event = null)
	{
		_manager.setArea(0, 0, Std.int(_stage.stageWidth), Std.int(_stage.stageHeight));
		_lockArea.setArea(_manager.areaX, _manager.areaY, _manager.areaWidth, _manager.areaHeight);
	}
}