package temperate.containers;
import flash.display.DisplayObject;
import flash.Lib;

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
			
			var invalidateClient = Lib.as(current, IInvalidateClient);
			if (invalidateClient != null)
			{
				invalidateClient.invalidate();
			}
		}
	}
}