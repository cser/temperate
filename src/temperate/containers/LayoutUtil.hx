package temperate.containers;
import flash.display.DisplayObject;

class LayoutUtil 
{
	public static function invalidateContainers(target:DisplayObject)
	{
		var current = target;
		while (true)
		{
			current = current.parent;
			if (current == null)
			{
				break;
			}
			
			if (Std.is(current, ICInvalidateClient))
			{
				cast(current, ICInvalidateClient).invalidate();
			}
		}
	}
}