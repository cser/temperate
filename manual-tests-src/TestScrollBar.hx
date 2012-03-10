package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageQuality;
import flash.errors.Error;
import flash.events.Event;
import helpers.Scaler;
import temperate.components.CScrollBar;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MInputField;
import temperate.minimal.MScrollBar;
import temperate.minimal.MTooltipFactory;
import temperate.raster.CScale3GridDrawer;
import temperate.raster.CScale9GridDrawer;
import temperate.skins.CRasterScrollDrawedSkin;
import temperate.text.CInputField;

class TestScrollBar extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		stage.quality = StageQuality.LOW;// To check bitmap data generation during low quality mode
		
		newScrollBar(true).addTo(this);
		newScrollBar(false).addTo(this, 100, 0);
		
		var scrollBar = newScrollBar(true).addTo(this, 0, 120);
		scrollBar.pageSize = 50;
		scrollBar.useHandCursor = true;
		MTooltipFactory.newText(scrollBar, "useHandCursor = true");
		var scrollBar = newScrollBar(false).addTo(this, 100, 120);
		scrollBar.pageSize = 50;
		
		var scrollBar = newScrollBar(false).addTo(this, 200, 120);
		scrollBar.pageSize = 50;
		addChild(new Scaler(scrollBar));
		
		var g = graphics;
		g.beginFill(0xeeeeee);
		g.drawRect(0, 290, 200, 300);
		g.endFill();
		
		newButtonsBlock().addTo(this, 10, 300);
		newButtonsBlock().addTo(this, 210, 300);
		
		var scrollBar = new MScrollBar(true).addTo(this, 300, 100);
		scrollBar.pageSize = 50;
		scrollBar.useHandCursor = true;
		MTooltipFactory.newText(scrollBar, "useHandCursor = true");
		addChild(new Scaler(scrollBar));
		
		var scrollBar = new MScrollBar(false).addTo(this, 410, 100);
		scrollBar.pageSize = 50;
		scrollBar.updateOnMove = true;
		MTooltipFactory.newText(scrollBar, "Using updateOnMove");
		addChild(new Scaler(scrollBar));
		
		new MScrollBar(true).addTo(this, 500, 100);
		new MScrollBar(false).addTo(this, 610, 100);
		
		var scrollBar = new MScrollBar(true).addTo(this, 650, 100);
		scrollBar.isEnabled = false;
		var scrollBar = new MScrollBar(false).addTo(this, 760, 100);
		scrollBar.isEnabled = false;
		
		if (Std.string(stage.quality).toLowerCase() != Std.string(StageQuality.LOW).toLowerCase())
		{
			throw new Error("Quality mast steel be low");
		}
		stage.quality = StageQuality.HIGH;
		
		initChangingBlock();
	}
	
	function newButtonsBlock()
	{
		var column = new CVBox();
		
		var line = new CHBox().addTo(column);
		line.add(new Bitmap(MScrollBarBdFactory.getLeftUp()));
		line.add(new Bitmap(MScrollBarBdFactory.getRightUp()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopUp()));
		line.add(new Bitmap(MScrollBarBdFactory.getBottomUp()));
		
		var line = new CHBox().addTo(column);
		line.add(new Bitmap(MScrollBarBdFactory.getLeftOver()));
		line.add(new Bitmap(MScrollBarBdFactory.getRightOver()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopOver()));
		line.add(new Bitmap(MScrollBarBdFactory.getBottomOver()));
		
		var line = new CHBox().addTo(column);
		line.add(new Bitmap(MScrollBarBdFactory.getLeftDown()));
		line.add(new Bitmap(MScrollBarBdFactory.getRightDown()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopDown()));
		line.add(new Bitmap(MScrollBarBdFactory.getBottomDown()));
		
		var line = new CHBox().addTo(column);
		line.add(new Bitmap(MScrollBarBdFactory.getLeftDisabled()));
		line.add(new Bitmap(MScrollBarBdFactory.getRightDisabled()));
		line.add(new Bitmap(MScrollBarBdFactory.getTopDisabled()));
		line.add(new Bitmap(MScrollBarBdFactory.getBottomDisabled()));
		
		var subBox = new CVBox().addTo(column);
		subBox.add(newShape(true, MScrollBarBdFactory.getHThumbUp()));
		subBox.add(newShape(true, MScrollBarBdFactory.getHThumbOver()));
		subBox.add(newShape(true, MScrollBarBdFactory.getHThumbDown()));
		
		var subBox = new CHBox().addTo(column);
		subBox.add(newShape(false, MScrollBarBdFactory.getVThumbUp()));
		subBox.add(newShape(false, MScrollBarBdFactory.getVThumbOver()));
		subBox.add(newShape(false, MScrollBarBdFactory.getVThumbDown()));
		
		return column;
	}
	
	function newScrollBar(horizontal)
	{
		return new CScrollBar(
			horizontal, new MButton().setText("-"),
			new MButton().setText("+"),
			new MButton().setText("::"),
			new CRasterScrollDrawedSkin(
				MCommonBdFactory.getTextBg(), new CScale9GridDrawer(), 18).setIndents(0, 0, 2)
		);
	}
	
	function newShape(horizontal:Bool, bd:BitmapData)
	{
		var width = horizontal ? 100 : bd.width;
		var height = horizontal ? bd.height : 100;
		var sprite = new Sprite();
		var drawer = new CScale3GridDrawer(horizontal, sprite.graphics);
		drawer.setBitmapData(bd);
		drawer.setBounds(0, 0, width, height);
		drawer.redraw();
		var bitmap = new Bitmap(
			horizontal ?
				MScrollBarBdFactory.getHThumbCenter() :
				MScrollBarBdFactory.getVThumbCenter()
		);
		bitmap.x = (width - Std.int(bitmap.width)) >> 1;
		bitmap.y = (height - Std.int(bitmap.height)) >> 1;
		sprite.addChild(bitmap);
		return sprite;
	}
	
	var _scrollBar:CScrollBar;
	var _scrollBarInput:CInputField;
	
	function initChangingBlock()
	{
		var box = new CVBox().addTo(this, 300, 300);
		_scrollBar = new MScrollBar(true).addTo(box);
		_scrollBar.width = 200;
		_scrollBar.minValue = 2;
		_scrollBar.maxValue = 12;
		_scrollBar.step = .5;
		_scrollBar.pageSize = 2;
		_scrollBar.addEventListener(Event.CHANGE, onScroll);
		
		_scrollBarInput = new MInputField().addTo(box);
		_scrollBarInput.addEventListener(Event.CHANGE, onScrollBarInputChange);
		onScroll();
	}
	
	function onScroll(event:Event = null)
	{
		_scrollBarInput.text = Std.string(_scrollBar.value);
		updateScrollBarInputState();
	}
	
	function onScrollBarInputChange(event:Event)
	{
		_scrollBar.value = Std.parseFloat(_scrollBarInput.text);
		updateScrollBarInputState();
	}
	
	function updateScrollBarInputState()
	{
		_scrollBarInput.isCorrect = Std.parseFloat(_scrollBarInput.text) == _scrollBar.value;
	}
}