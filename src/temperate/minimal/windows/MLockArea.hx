package temperate.minimal.windows;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import temperate.core.ICArea;
import temperate.minimal.MTween;
import temperate.windows.CPopUpManager;
using temperate.core.CMath;

class MLockArea extends Sprite, implements ICArea
{
	public function new() 
	{
		super();
		
		container = this;
		areaX = 0;
		areaY = 0;
		areaWidth = 100;
		areaHeight = 100;
		color = 0x50000000;
		visible = false;
		alpha = 0;
		redraw();
	}
	
	public var container(default, null):DisplayObjectContainer;
	
	public var areaX(default, null):Int;
	
	public var areaY(default, null):Int;
	
	public var areaWidth(default, null):Int;
	
	public var areaHeight(default, null):Int;
	
	public function setArea(x:Int, y:Int, width:Int, height:Int):Void
	{
		areaX = x;
		areaY = y;
		areaWidth = width;
		areaHeight = height;
		redraw();
	}
	
	public var color(default, null):UInt;
	
	public function setColor(color:UInt):MLockArea
	{
		this.color = color;
		redraw();
		return this;
	}
	
	function redraw()
	{
		var g = graphics;
		g.clear();
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRect(areaX, areaY, areaWidth, areaHeight);
		g.endFill();
	}
	
	var _manager:CPopUpManager;
	
	public function setManager(manager:CPopUpManager):MLockArea
	{
		if (_manager != manager)
		{
			if (_manager != null)
			{
				_manager.removeEventListener(Event.CHANGE, onManagerChange);
			}
			_manager = manager;
			if (_manager != null)
			{
				_manager.addEventListener(Event.CHANGE, onManagerChange);
			}
			onManagerChange();
		}
		return this;
	}
	
	function onManagerChange(event:Event = null)
	{
		if (_manager.modal)
		{
			visible = true;
			MTween.to(this, 200, { alpha:1 } );
		}
		else
		{
			MTween.to(this, 200, { alpha:0 } ).setVoidOnComplete(onFadeOutComplete);
		}
	}
	
	function onFadeOutComplete()
	{
		visible = false;
	}
}