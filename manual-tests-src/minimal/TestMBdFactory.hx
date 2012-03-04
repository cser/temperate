package minimal;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import temperate.containers.CHBox;
import temperate.core.CGraphicsUtil;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.graphics.MFlatBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;

class TestMBdFactory extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var line = new CHBox().addTo(this, 10, 10);
		line.add(new Bitmap(MCommonBdFactory.getButtonBgUp()));
		line.add(new Bitmap(MCommonBdFactory.getButtonBgDown()));
		line.add(new Bitmap(MCommonBdFactory.getButtonBgUpSelected()));
		line.add(new Bitmap(MCommonBdFactory.getButtonBgDownSelected()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgUp()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgDown()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgUpSelected()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgDownSelected()));
		line.add(new Bitmap(MCommonBdFactory.getRadioButtonBgUp()));
		line.add(new Bitmap(MCommonBdFactory.getRadioButtonBgDown()));
		line.add(new Bitmap(MCommonBdFactory.getRadioButtonBgUpSelected()));
		line.add(new Bitmap(MCommonBdFactory.getRadioButtonBgDownSelected()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopUp()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopOver()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopDown()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopDisabled()));
		line.add(new Bitmap(MScrollBarBdFactory.getHThumbUp()));
		line.add(new Bitmap(MScrollBarBdFactory.getHThumbOver()));
		line.add(new Bitmap(MScrollBarBdFactory.getHThumbDown()));
		line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbUp()));
		line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbOver()));
		line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbDown()));
		line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbDisabled()));
		line.add(new Bitmap(MFlatBdFactory.getBgUp()));
		line.add(new Bitmap(MFlatBdFactory.getBgOver()));
		line.add(new Bitmap(MFlatBdFactory.getBgDown()));
		line.add(new Bitmap(MFlatBdFactory.getBgDisabled()));
		
		var shape = new Shape();
		addChild(shape);
		CGraphicsUtil.drawCircleBorder(shape.graphics, 100, 300, 50, 10, 0x808080, 1);
		CGraphicsUtil.drawTopLeftBorder(
			shape.graphics, 300, 300, 100, 100, 20, 0x808080, 1, 10, true);
		CGraphicsUtil.drawTopLeftBorder(
			shape.graphics, 500, 300, 100, 100, 20, 0x808080, 1, 10, false);
		
		var shape = new Shape();
		shape.y = 400;
		addChild(shape);
		var g = shape.graphics;
		g.lineStyle(0, 0xff0000);
		g.moveTo(50, 100);
		CGraphicsUtil.drawArc(g, 50, 50, 50, .5 * Math.PI, 1.5 * Math.PI);
		g.lineTo(100, 0);
		CGraphicsUtil.drawArc(g, 100, 50, 50, 1.5 * Math.PI, .5 * Math.PI);
		g.lineTo(50, 100);
		
		var shape = new Shape();
		shape.x = 300;
		shape.y = 400;
		addChild(shape);
		var g = shape.graphics;
		g.lineStyle(0, 0xff0000);
		CGraphicsUtil.drawRoundRectComplexStepByStep(g, 10, 20, 100, 50, 10, 20, 5, 2);
	}
}