package temperate.minimal;
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;
import flash.Lib;
import temperate.minimal.animators.MAlphaAnimator;
import temperate.minimal.renderers.MTextTooltip;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.docks.CHTooltipDock;
import temperate.tooltips.docks.CVTooltipDock;
import temperate.tooltips.docks.ICTooltipDock;
import temperate.tooltips.managers.CTooltipManager;
import temperate.tooltips.renderers.ICTooltip;
import temperate.tooltips.tooltipers.CForcedTargetTooltiper;
import temperate.tooltips.tooltipers.CMouseTooltiper;
import temperate.tooltips.tooltipers.CTargetMouseTooltiper;
import temperate.tooltips.tooltipers.CTargetTooltiper;

class MTooltipFactory 
{
	public static var DOCK_VERTICAL_TOP:ICTooltipDock = new CVTooltipDock();
	public static var DOCK_VERTICAL_BOTTOM:ICTooltipDock = new CVTooltipDock()
		.setDefaultTop(false);
	public static var DOCK_HORIZONTAL_LEFT:ICTooltipDock = new CHTooltipDock();
	public static var DOCK_HORIZONTAL_RIGHT:ICTooltipDock = new CHTooltipDock()
		.setDefaultLeft(false);
	
	public static var owner(get_owner, null):CTooltipOwner;
	static var _owner:CTooltipOwner;
	static function get_owner()
	{
		if (_owner == null)
		{
			_stage = Lib.current.stage;
			_owner = new CTooltipOwner(_stage);
			_stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize();
		}
		return _owner;
	}
	
	public static var manager(get_manager, null):CTooltipManager;
	static var _manager:CTooltipManager;
	static function get_manager()
	{
		if (_manager == null)
		{
			_manager = new CTooltipManager();
		}
		return _manager;
	}
	
	static var _stage:Stage;
	
	static function onStageResize(event:Event = null)
	{
		_owner.right = _stage.stageWidth;
		_owner.bottom = _stage.stageHeight;
	}
	
	static function newDefaultAnimator<T>()
	{
		return new MAlphaAnimator<T>(350, 450);
	}
	
	public static function newText(
		target:DisplayObject, text:String = null
	):CTargetTooltiper<String>
	{
		var result = new CTargetTooltiper(owner, manager)
			.setTooltipClass(MTextTooltip)
			.setTarget(target)
			.setAnimator(newDefaultAnimator());
		if (text != null)
		{
			result.setData(text);
		}
		return result;
	}
	
	public static function newTextMoused(
		target:DisplayObject, text:String = null):CTargetMouseTooltiper<String>
	{
		var result = new CTargetMouseTooltiper(owner, manager)
			.setTooltipClass(MTextTooltip)
			.setTarget(target)
			.setAnimator(newDefaultAnimator());
		if (text != null)
		{
			result.setData(text);
		}
		return result;
	}
	
	public static function newTargeted<T>(target:DisplayObject):CTargetTooltiper<T>
	{
		var result = new CTargetTooltiper<T>(owner, manager)
			.setTarget(target)
			.setAnimator(newDefaultAnimator());
		return result;
	}
	
	public static function newTargetedMoused<T>(target:DisplayObject):CTargetMouseTooltiper<T>
	{
		return new CTargetMouseTooltiper<T>(owner, manager)
			.setTarget(target)
			.setAnimator(newDefaultAnimator());
	}
	
	static var _forcedTooltiper:CForcedTargetTooltiper;
	
	public static function showForced<T>(
		target:DisplayObject, rendererClass:Class<ICTooltip<T>>, data:T)
	{
		if (_forcedTooltiper == null)
		{
			_forcedTooltiper = new CForcedTargetTooltiper(owner, manager)
				.setAnimator(newDefaultAnimator());
		}
		_forcedTooltiper.showClass(target, rendererClass, data);
	}
	
	public static function hideForced()
	{
		if (_forcedTooltiper != null)
		{
			_forcedTooltiper.hide();
		}
	}
	
	static var _mousedTooltiper:CMouseTooltiper;
	
	public static function showMoused<T>(rendererClass:Class<ICTooltip<T>>, data:T)
	{
		if (_mousedTooltiper == null)
		{
			_mousedTooltiper = new CMouseTooltiper(owner, manager)
				.setAnimator(newDefaultAnimator());
		}
		_mousedTooltiper.showClass(rendererClass, data);
	}
	
	public static function hideMoused()
	{
		if (_mousedTooltiper != null)
		{
			_mousedTooltiper.hide();
		}
	}
}