package temperate.windows.components;
import flash.events.Event;

class CWindowMaximizeComponent extends ACWindowComponent
{
	public function new() 
	{
		super();
	}
	
	var _width:Int;
	var _height:Int;
	
	override function doSubscribe():Void
	{
		_width = super.getWidth();
		_height = super.getHeight();
		_popUp.innerDispatcher.addEventListener(Event.RESIZE, onResize);
		var manager = _getManager();
		super.move(manager.areaX, manager.areaY, false);
		onResize();
	}
	
	override function doUnsubscribe():Void
	{
		_popUp.innerDispatcher.removeEventListener(Event.RESIZE, onResize);
		super.setSize(_width, _height);
		var manager = _getManager();
		var dock = _getDock();
		dock.arrange(getWidth(), getHeight(), manager.areaWidth, manager.areaHeight);
		super.move(manager.areaX + dock.x, manager.areaY + dock.y, false);
	}
	
	function onResize(event:Event = null)
	{
		var manager = _getManager();
		super.setSize(manager.areaWidth, manager.areaHeight);
		super.move(manager.areaX, manager.areaY, false);
	}
	
	override public function move(x:Int, y:Int, needSave:Bool):Void
	{
	}
	
	override public function setSize(width:Int, height:Int):Void
	{
	}
	
	override public function moveDock(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, x:Int, y:Int, needSave:Bool):Void
	{
	}
}