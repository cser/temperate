package windowApplication;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.core.CSprite;
import temperate.cursors.CCursor;
import temperate.cursors.CHoverSwitcher;
import temperate.cursors.ICCursor;
import temperate.minimal.MCursorManager;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MScrollPane;
import temperate.minimal.windows.AMWindow;
import temperate.windows.events.CWindowEvent;
import windowApplication.events.ImageWindowEvent;
import windowApplication.states.PencilDrawState;

class ImageWindow extends AMWindow<Dynamic>
{
	public function new(name:String, editorState:EditorState) 
	{
		super();
		
		image = new CSprite();
		primitives = new Primitives();
		primitives.changed.add(updateTitle);
		this.name = name;
		
		isImageOpened = false;
		_savedPrimitivesLength = 0;
		_editorState = editorState;
		
		_skin.addHeadButton(_skin.getMaximizeButton())
			.addEventListener(Event.CHANGE, onMaximizeChange);
		_skin.addHeadButton(_skin.getCloseButton())
			.addEventListener(MouseEvent.CLICK, onCloseClick);
		resizable = true;
		
		_pane = new MScrollPane();
		_pane.set(image);
		_main.add(_pane).setPercents(100, 100);
		
		_toolCursor = MCursorManager.newHover( -1).setTarget(image);
	}
	
	function updateTitle()
	{
		title = name + (isChanged ? "*" : "");
	}
	
	var _editorState:EditorState;
	var _pane:MScrollPane;
	var _toolCursor:CHoverSwitcher<ICCursor>;
	
	public var name(default, set_name):String;
	function set_name(value)
	{
		name = value;
		updateTitle();
		return name;
	}
	
	public var image(default, null):CSprite;
	
	public var primitives(default, null):Primitives;
	
	public function setImageSize(width:Int, height:Int)
	{
		image.setSize(width, height);
		redrawBg();
	}
	
	public var isImageOpened(default, null):Bool;
	
	public var isChanged(get_changed, null):Bool;
	function get_changed()
	{
		return primitives.length > _savedPrimitivesLength;
	}
	
	var _savedPrimitivesLength:Int;
	
	public function markAsSaved()
	{
		isImageOpened = true;
		_savedPrimitivesLength = primitives.length;
		updateTitle();
	}
	
	public function drawPrimitives(primitives:Primitives)
	{
		if (this.primitives != null)
		{
			this.primitives.changed.remove(updateTitle);
		}
		this.primitives = primitives;
		primitives.changed.add(updateTitle);
		redrawBg();
		var g = image.graphics;
		g.lineStyle(0, 0x000000);
		for (primitive in primitives)
		{
			switch (primitive)
			{
				case MOVE_TO(x, y):
					g.moveTo(x, y);
				case LINE_TO(x, y):
					g.lineTo(x, y);
				case ELLIPSE(x, y, width, height):
					g.drawEllipse(x, y, width, height);
				case RECT(x, y, width, height):
					g.drawRect(x, y, width, height);
				case LINE_STYLE(color):
					g.lineStyle(0, color);
				case TF(x, y, width, height, text, color):
					var tf = MFormatFactory.LABEL.clone().setColor(color).newFixed(false);
					tf.x = x;
					tf.y = y;
					tf.width = width;
					tf.height = height;
					tf.wordWrap = true;
					tf.text = text;
					image.addChild(tf);
			}
		}
		markAsSaved();
		updateTitle();
	}
	
	function redrawBg()
	{
		var g = image.graphics;
		g.clear();
		g.beginFill(0xffffff);
		g.drawRect(0, 0, image.width, image.height);
		g.endFill();
		_pane.invalidate();
	}
	
	function onMaximizeChange(event:Event)
	{
		maximized = _skin.getMaximizeButton().selected;
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close(null);
	}
	
	override function doOnShow()
	{
		_editorState.toolChanged.add(onToolChanged);
		onToolChanged();
	}
	
	override function doOnHide()
	{
		_editorState.toolChanged.remove(onToolChanged);
	}
	
	function onToolChanged()
	{
		var state = _editorState.tool;
		if (state != null)
		{
			var cursorView = new Bitmap(state.icon);
			var cursor = new CCursor();
			if (Std.is(state, PencilDrawState))
			{
				cursor.setView(cursorView, true, 0, -Std.int(cursorView.height));
				cursor.setHideSystem(true);
			}
			else
			{
				cursor.setView(cursorView, true, 10, 14);
			}
			_toolCursor.value = cursor;
		}
		else
		{
			_toolCursor.value = null;
		}
	}
}