package temperate.windows.components;
import flash.events.Event;

class CWindowMaximizeComponent extends ACWindowComponent
{
	public function new() 
	{
		super();
	}
	
	private var _x:Int;
	private var _y:Int;
	private var _width:Int;
	private var _height:Int;
	
	override function doSubscribe():Void
	{
		_x = super.getX();
		_y = super.getY();
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
		super.move(_x, _y, false);
	}
	
	function onResize(event:Event = null)
	{
		var manager = _getManager();
		super.setSize(manager.areaWidth, manager.areaHeight);
	}
	
	override public function move(x:Int, y:Int, needSave:Bool):Void
	{
	}
	
	override public function setSize(width:Int, height:Int):Void
	{
	}
}