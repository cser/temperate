package windowApplication;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.ui.Keyboard;
import temperate.components.CButtonSelector;
import temperate.components.CButtonState;
import temperate.components.CRasterImageButton;
import temperate.containers.CHBox;
import temperate.core.CGraphicsUtil;
import temperate.core.CSprite;
import temperate.minimal.windows.AMWindow;

class ColorsWindow extends AMWindow<Dynamic>
{
	var _editorState:EditorState;
	var _colors:CButtonSelector<UInt>;
	
	public function new(editorState:EditorState) 
	{
		super();
		
		title = "Colors";
		
		_main.gapY = 0;
		
		_colors = new CButtonSelector(editorState.color, true);
		_colors.addEventListener(Event.CHANGE, onColorChange);
		var glow = [ new GlowFilter(0xffffff, 1, 4, 4, 10, 1, true) ];
		var colors:Array<UInt> = [
			0xeeeeee, 0x000000, 0xff0000, 0x00ff00, 0x0000ff,
			0xffff00, 0x00ffff, 0x808080, 0x800000, 0x008000,
			0x808000, 0x008080, 0x00ff80, 0x80ff00, 0xff80ff];
		var line = null;
		var i = 0;
		for (color in colors)
		{
			if (i % 5 == 0)
			{
				line = new CHBox();
				line.gapX = 0;
				_main.add(line);
			}
			var image = new CSprite();
			image.width = 20;
			image.height = 20;
			var g = image.graphics;
			g.beginFill(0x000000);
			CGraphicsUtil.drawRectBorder(g, 0, 0, image.width, image.height, 1);
			g.endFill();
			g.beginFill(color);
			g.drawRect(1, 1, image.width - 2, image.height - 2);
			g.endFill();
			var button = new CRasterImageButton();
			button.setTextIndents(0, 0, 0, 0);
			button.getImage(CButtonState.UP).setImage(image);
			button.getImage(CButtonState.OVER).setFilters(null);
			button.getImage(CButtonState.UP_SELECTED).setFilters(glow);
			button.getImage(CButtonState.OVER_SELECTED).setFilters(glow);
			button.getImage(CButtonState.DOWN_SELECTED).setFilters(glow);
			line.add(button);
			_colors.add(button, color);
			i++;
		}
		
		_editorState = editorState;
		
		_skin.addHeadButton(_skin.getCloseButton()).addEventListener(MouseEvent.CLICK, onCloseClick);
		innerDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	function onColorChange(event:Event)
	{
		_editorState.color = _colors.value;
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close(null);
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		if (event.keyCode == Keyboard.ESCAPE)
		{
			close(null);
		}
	}
}