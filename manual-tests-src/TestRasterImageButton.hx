package ;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import temperate.components.CButtonState;
import temperate.components.CRasterImageButton;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.docks.CRightDock;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.MFilterFactory;
import temperate.minimal.MFlatImageButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MImageButton;

class TestRasterImageButton extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		
		{
			var line = new CHBox().addTo(main);
			
			var button = newButton();
			button.text = "Image button";
			button.getImage(CButtonState.UP).setImage(newImage(50, 30, 0xa0a0a0));
			button.getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT);
			button.getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT);
			line.add(button);
			
			var button = newButton();
			button.text = "Image button\n(selected)";
			button.getImage(CButtonState.UP).setImage(newImage(50, 30, 0xa0a0a0));
			button.getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT);
			button.getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT);
			button.selected = true;
			line.add(button);
			
			var button = newButton();
			button.text = "Image button\n(selected with\nother image)";
			button.getImage(CButtonState.UP).setImage(newImage(50, 30, 0xa0a0a0));
			button.getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT);
			button.getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT);
			button.getImage(CButtonState.UP_SELECTED).setImage(newImage(50, 30, 0x8090ff));
			button.selected = true;
			line.add(button);
			
			var button = newButton();
			button.text = "Image button\n(with offsets)";
			button.getImage(CButtonState.UP).setImage(newImage(50, 30, 0xa0a0a0));
			button.getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT)
				.setOffset(-1, -1);
			button.getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT);
			line.add(button);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			var button = new MImageButton();
			button.text = "MImageButton";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.textDock = new CRightDock(2, 1);
			button.setSize(150, 100);
			line.add(button);
			
			var button = new MImageButton();
			button.text = "MImageButton (selected)";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.selected = true;
			line.add(button);
			
			var button = new MImageButton();
			button.text = "MImageButton (disabled)";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.isEnabled = false;
			line.add(button);
			
			var button = new MImageButton();
			button.text = "MImageButton (selected disabled)";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.selected = true;
			button.isEnabled = false;
			line.add(button);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			var button = new MFlatImageButton();
			button.text = "MFlatImageButton";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT);
			button.getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT);
			button.textDock = new CRightDock(2, 1);
			button.setSize(150, 100);
			line.add(button);
			
			var button = new MFlatImageButton();
			button.text = "MFlatImageButton\n(selected)";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.selected = true;
			line.add(button);
			
			var button = new MFlatImageButton();
			button.text = "MFlatImageButton\n(disabled)";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.isEnabled = false;
			line.add(button);
			
			var button = new MFlatImageButton();
			button.text = "MFlatImageButton\n(selected disabled)";
			button.getImage(CButtonState.UP).setImage(newImage(20, 10, 0xa0a0a0));
			button.selected = true;
			button.isEnabled = false;
			line.add(button);
		}
	}
	
	function newButton():CRasterImageButton
	{
		var button = new CRasterImageButton();
		button.getState(CButtonState.UP)
			.setBitmapData(MCommonBdFactory.getButtonBgUp())
			.setFormat(MFormatFactory.BUTTON_UP)
			;
		button.getState(CButtonState.OVER)
			.setBitmapData(MCommonBdFactory.getButtonBgUp())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			;
		button.getState(CButtonState.DOWN)
			.setBitmapData(MCommonBdFactory.getButtonBgDown())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setTextOffset(1, 1)
			.setBgOffset(1, 1, 1, 1)
			;
		button.getState(CButtonState.DISABLED)
			.setBitmapData(MCommonBdFactory.getButtonBgDown())
			.setAlpha(.5)
			.setFormat(MFormatFactory.BUTTON_DISABLED)
			;
		button.getState(CButtonState.UP_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgUpSelected())
			;
		button.getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			;
		button.getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setTextOffset(1, 1)
			.setBgOffset(1, 1, 1, 1)
			;
		button.getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgDownSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.BUTTON_DISABLED)
			;
		return button;
	}
	
	function newImage(width:Int, height:Int, color:UInt):DisplayObject
	{
		var image = new Shape();
		var g = image.graphics;
		g.lineStyle(0, 0x000000);
		g.beginFill(color);
		g.drawRect(0, 0, width, height);
		g.endFill();
		return image;
	}
}