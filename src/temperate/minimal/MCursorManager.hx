package temperate.minimal;
import flash.display.Stage;
import flash.Lib;
import temperate.collections.ICValueSwitcher;
import temperate.cursors.CCursorManager;
import temperate.cursors.CHoverSwitcher;
import temperate.cursors.ICCursor;

class MCursorManager 
{
	static var _manager:CCursorManager;
	
	static function getManager():CCursorManager
	{
		if (_manager == null)
		{
			var stage:Stage = Lib.current.stage;
			_manager = new CCursorManager(stage, stage);
		}
		return _manager;
	}
	
	public static var defaultCursor(get_defaultCursor, set_defaultCursor):ICCursor;
	static function get_defaultCursor()
	{
		return getManager().defaultCursor;
	}
	static function set_defaultCursor(value)
	{
		return getManager().defaultCursor = value;
	}
	
	public static function newSwitcher(priority:Int = 0):ICValueSwitcher<ICCursor>
	{
		return getManager().newSwitcher(priority);
	}
	
	public static function newHover(priority:Int = 0):CHoverSwitcher<ICCursor>
	{
		return getManager().newHover(priority);
	}
	
	@:require(flash10_2) public static function addNative(
		name:String, data:flash.Vector<flash.display.BitmapData>, frameRate:Float,
		hotSpot:flash.geom.Point)
	{
		#if flash10_2
		getManager().addNative(name, data, frameRate, hotSpot);
		#end
	}
}