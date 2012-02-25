package temperate.windows.components;

class CWindowConstraintsComponent extends ACWindowComponent
{
	public function new() 
	{
		super();
	}
	
	override public function move(x:Int, y:Int, needSave:Bool):Void
	{
		var manager = _getManager();
		if (manager != null)
		{
			var width = getWidth();
			var height = getHeight();
			if (x < manager.areaX - width * .5)
			{
				x = Std.int(manager.areaX - width * .5);
			}
			else if (x > manager.areaX + manager.areaWidth - width * .5)
			{
				x = Std.int(manager.areaX + manager.areaWidth - width * .5);
			}
			if (y < manager.areaY)
			{
				y = Std.int(manager.areaY);
			}
			else if (y > manager.areaY + manager.areaHeight - _skin.headHeight)
			{
				y = Std.int(manager.areaY + manager.areaHeight - _skin.headHeight);
			}
		}
		super.move(x, y, needSave);
	}
}