package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterFixedButton;
import temperate.components.CRasterThumb;
import temperate.components.CScrollBar;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.skins.CNullRectSkin;

class MScrollBar extends CScrollBar
{
	public function new(horizontal:Bool) 
	{
		var leftArrow = new CRasterFixedButton();
		leftArrow.getState(CButtonState.UP).setBitmapData(
			horizontal ? MScrollBarBdFactory.getLeftUp() : MScrollBarBdFactory.getTopUp());
		leftArrow.getState(CButtonState.OVER).setBitmapData(
			horizontal ? MScrollBarBdFactory.getLeftOver() : MScrollBarBdFactory.getTopOver());
		leftArrow.getState(CButtonState.DOWN).setBitmapData(
			horizontal ? MScrollBarBdFactory.getLeftDown() : MScrollBarBdFactory.getTopDown());
		leftArrow.getState(CButtonState.DISABLED).setBitmapData(
			horizontal ?
				MScrollBarBdFactory.getLeftDisabled() :
				MScrollBarBdFactory.getTopDisabled());
		var rightArrow = new CRasterFixedButton();
		rightArrow.getState(CButtonState.UP).setBitmapData(
			horizontal ? MScrollBarBdFactory.getRightUp() : MScrollBarBdFactory.getBottomUp());
		rightArrow.getState(CButtonState.OVER).setBitmapData(
			horizontal ? MScrollBarBdFactory.getRightOver() : MScrollBarBdFactory.getBottomOver());
		rightArrow.getState(CButtonState.DOWN).setBitmapData(
			horizontal ? MScrollBarBdFactory.getRightDown() : MScrollBarBdFactory.getBottomDown());
		rightArrow.getState(CButtonState.DISABLED).setBitmapData(
			horizontal ?
				MScrollBarBdFactory.getRightDisabled() :
				MScrollBarBdFactory.getBottomDisabled());
		var thumb = new CRasterThumb(horizontal);
		thumb.getState(CButtonState.UP).setBitmapData(
			horizontal ? MScrollBarBdFactory.getHThumbUp() : MScrollBarBdFactory.getVThumbUp());
		thumb.getState(CButtonState.OVER).setBitmapData(
			horizontal ? MScrollBarBdFactory.getHThumbOver() : MScrollBarBdFactory.getVThumbOver());
		thumb.getState(CButtonState.DOWN).setBitmapData(
			horizontal ? MScrollBarBdFactory.getHThumbDown() : MScrollBarBdFactory.getVThumbDown());
		if (horizontal)
		{
			thumb.setIcon(MScrollBarBdFactory.getHThumbCenter(), 0, 0);
		}
		else
		{
			thumb.setIcon(MScrollBarBdFactory.getVThumbCenter(), 0, 0);
		}
		thumb.setGrid3Insets(5, 5);
		thumb.setMinSizeParams(10, 16);
		var bg = CNullRectSkin.getInstance();
		super(horizontal, leftArrow, rightArrow, thumb, bg);
	}
	
	override function updateBg()
	{
		var bd = _horizontal ? MScrollBarBdFactory.getHBgUp() : MScrollBarBdFactory.getVBgUp();
		var g = _bg.graphics;
		var indent = 3;
		g.clear();
		g.beginBitmapFill(bd);
		if (_horizontal)
		{
			g.drawRect(indent, 0, _width - indent * 2, _height);
		}
		else
		{
			g.drawRect(0, indent, _width, _height - indent * 2);
		}
		g.endFill();
	}
}