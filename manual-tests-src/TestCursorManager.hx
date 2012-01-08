package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Lib;
import flash.ui.MouseCursor;
import flash.Vector;
import temperate.containers.CVBox;
import temperate.cursors.CCursor;
import temperate.cursors.CCursorManager;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.graphics.MCursorBdFactory;
import temperate.minimal.MButton;

class TestCursorManager extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _manager:CCursorManager;
	
	public function init()
	{
		_manager = new CCursorManager(this, Lib.current.stage);
		
		var box = new CVBox().addTo(this, 20, 10);
		
		box.add(new MButton().setText("Set null cursor")
			.addClickHandler(callback(onChangeCursorClick, null)));
		
		var cursor = new CCursor().setSystem(MouseCursor.IBEAM);
		box.add(new MButton().setText("Set IBEAM cursor")
			.addClickHandler(callback(onChangeCursorClick, cursor)));
		
		var cursor = new CCursor()
			.setView(new Bitmap(MCommonBdFactory.getButtonBgDown()), true, -10, -10)
			.setHideSystem(false);
		box.add(new MButton().setText("Set display object cursor")
			.addClickHandler(callback(onChangeCursorClick, cursor)));
			
		_manager.defaultCursor = cursor;
		
		{
			var button = new MButton();
			button.addTo(this, 200, 110);
			button.setSize(100, 100);
			button.text = "ARROW";
			button.setTextAlign(1, .5);
			_manager.newHover().setTarget(button)
				.setValue(new CCursor().setSystem(MouseCursor.ARROW));
			
			var button = new MButton();
			button.addTo(this, 150, 100);
			button.setSize(100, 100);
			button.text = "IBEAM";
			_manager.newHover().setTarget(button)
				.setValue(new CCursor().setSystem(MouseCursor.IBEAM));
		}
		
		{
			#if flash10_2
			
			var data = new Vector();
			data[0] = MCursorBdFactory.getWait();
			_manager.addNative("native", data, 1, new Point(10, 10));
			
			var button = new MButton();
			button.text = "Native flashplayer 10.2 cursor";
			button.setSize(200, 150);
			button.addTo(this, -5, 300);
			
			_manager.newHover().setTarget(button).setValue(new CCursor().setSystem("native"));
			
			#end
		}
	}
	
	function onChangeCursorClick(cursor:CCursor, event:MouseEvent)
	{
		_manager.defaultCursor = cursor;
	}
}