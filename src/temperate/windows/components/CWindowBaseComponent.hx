package temperate.windows.components;
import temperate.windows.ICPopUp;

class CWindowBaseComponent extends ACWindowComponent
{
	public function new() 
	{
		super();
	}
	
	override public function animateShow(fast:Bool):Void
	{
	}
	
	override public function animateHide(fast:Bool, onComplete:ICPopUp->Void):Void
	{
		if (onComplete != null)
		{
			onComplete(_popUp);
		}
	}
	
	override public function getWidth():Int
	{
		return Std.int(_view.width);
	}
	
	override public function getHeight():Int
	{
		return Std.int(_view.height);
	}
	
	override public function setSize(width:Int, height:Int):Void
	{
		_view.width = width;
		_view.height = height;
	}
	
	override public function getX():Int
	{
		return Std.int(_view.x);
	}
	
	override public function getY():Int
	{
		return Std.int(_view.y);
	}
	
	override public function move(x:Int, y:Int, needSave:Bool):Void
	{
		_view.x = x;
		_view.y = y;
	}
	
	override public function moveDock(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, x:Int, y:Int, needSave:Bool):Void
	{
		var dock = _getDock();
		dock.move(width, height, mainWidth, mainHeight, x, y, needSave);
	}
}