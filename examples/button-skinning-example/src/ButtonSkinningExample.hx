package ;

import assets.generated.ButtonDisabled;
import assets.generated.ButtonDisabledSelected;
import assets.generated.ButtonDown;
import assets.generated.ButtonDownSelected;
import assets.generated.ButtonOver;
import assets.generated.ButtonOverSelected;
import assets.generated.ButtonUp;
import assets.generated.ButtonUpSelected;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;
import flash.Lib;
import temperate.components.CButtonState;
import temperate.components.CRasterScaledButton;
import temperate.containers.CVBox;
import temperate.text.CTextFormat;

class ButtonSkinningExample 
{	
	static function main() 
	{
		var box = new CVBox();
		box.x = 10;
		box.y = 10;
		box.gapY = 0;
		Lib.current.addChild(box);
		
		box.add(newButton().setText("Normal button")).setPercents(100);
		
		var button = newButton().setText("Selected button");
		button.selected = true;
		box.add(button).setPercents(100);
		
		var button = newButton().setText("Disabled button");
		button.isEnabled = false;
		box.add(button).setPercents(100);
		
		var button = newButton().setText("Selected disabled button");
		button.selected = true;
		button.isEnabled = false;
		box.add(button).setPercents(100);
	}
	
	static function newButton()
	{
		var format = new CTextFormat("Tahoma", 14);
		var overFormat = format.clone().setFilters([ new GlowFilter(0xffff00, 1, 2, 2, 2) ]);
		var disabledFormat = format.clone().setAlpha(.5).setFilters([ new BlurFilter(2, 2) ]);
		var button = new CRasterScaledButton();
		button.getState(CButtonState.UP) 
			.setBitmapData(new ButtonUp())
			.setFormat(format)
			;
		button.getState(CButtonState.OVER) 
			.setBitmapData(new ButtonOver())
			.setFormat(overFormat)
			;
		button.getState(CButtonState.DOWN) 
			.setBitmapData(new ButtonDown())
			.setFormat(overFormat)
			.setTextOffset(1, 1)
			;
		button.getState(CButtonState.DISABLED) 
			.setBitmapData(new ButtonDisabled())
			.setFormat(disabledFormat)
			;
		button.getState(CButtonState.UP_SELECTED) 
			.setBitmapData(new ButtonUpSelected())
			.setFormat(format)
			;
		button.getState(CButtonState.OVER_SELECTED) 
			.setBitmapData(new ButtonOverSelected())
			.setFormat(overFormat)
			;
		button.getState(CButtonState.DOWN_SELECTED) 
			.setBitmapData(new ButtonDownSelected())
			.setFormat(overFormat)
			.setTextOffset(1, 1)
			;
		button.getState(CButtonState.DISABLED_SELECTED) 
			.setBitmapData(new ButtonDisabledSelected())
			.setFormat(disabledFormat)
			;
		button.setTextAlign(0, .5);
		button.setTextIndents(20, 5, 2, 2);
		return button;
	}
	
}