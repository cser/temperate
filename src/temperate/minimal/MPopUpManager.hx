package temperate.minimal;
import flash.display.Stage;
import flash.events.Event;
import flash.Lib;
import temperate.minimal.windows.MLockArea;
import temperate.windows.CPopUpManager;
import temperate.windows.ICPopUp;

class MPopUpManager extends CPopUpManager
{
	public static var instance(get_instance, null):MPopUpManager;
	static var _instance:MPopUpManager;
	static function get_instance():MPopUpManager
	{
		if (_instance == null)
		{
			_instance = new MPopUpManager(Lib.current.stage);
		}
		return _instance;
	}
	
	var _stage:Stage;
	var _lockArea:MLockArea;
	
	function new(stage:Stage)
	{
		super(stage);
		
		_stage = stage;
		_lockArea = new MLockArea().setManager(this);
		_stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
	}
	
	function onStageResize(event:Event = null)
	{
		setArea(0, 0, Std.int(_stage.stageWidth), Std.int(_stage.stageHeight));
		_lockArea.setArea(areaX, areaY, areaWidth, areaHeight);
	}
	
	override public function add(popUp:ICPopUp, modal:Bool, fast:Bool = false)
	{
		super.add(popUp, modal, fast);
		var indices = [];
		for (popUpI in _popUps)
		{
			indices.push(container.getChildIndex(popUpI.view));
		}
		trace("indices: " + indices);
		var index = container.getChildIndex(_popUps[0].view);
		var lockView = _lockArea.container;
		if (lockView.parent != container)
		{
			container.addChildAt(_lockArea, index);
		}
		else
		{
			var lockIndex = container.getChildIndex(lockView);
			if (lockIndex > index)
			{
				container.setChildIndex(_lockArea, index);
			}
		}
		var indices = [];
		for (i in 0 ... container.numChildren)
		{
			indices.push(container.getChildAt(i));
		}
		trace(indices);
	}
}