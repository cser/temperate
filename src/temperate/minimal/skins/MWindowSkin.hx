package temperate.minimal.skins;
import flash.display.Bitmap;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import flash.text.TextField;
import temperate.components.ICButton;
import temperate.core.CMath;
import temperate.minimal.graphics.MWindowBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.windows.MCloseButton;
import temperate.minimal.windows.MMaximizeButton;
import temperate.raster.CVScale12GridDrawer;
import temperate.skins.ACWindowSkin;

class MWindowSkin extends ACWindowSkin
{
	static var HINDENT = 4;
	static var VINDENT = 4;
	static var LINE_TOP_INDENT = 2;
	static var LINE_BOTTOM_INDENT = 4;
	static var CENTER_TOP_OFFSET = -2;
	static var BUTTONS_RIGHT = 6;
	static var BUTTONS_INDENT = 2;
	
	public function new() 
	{
		super();
		
		_drawer = new CVScale12GridDrawer();
		_drawer.setBitmapData(MWindowBdFactory.getFrame());
		_drawer.setInsets(
			10, 12, 10, 12, MWindowBdFactory.FRAME_CENTER_TOP + CENTER_TOP_OFFSET, 2);
		
		_head = new Sprite();
		_head.useHandCursor = true;
		_head.buttonMode = true;
		addChild(_head);
		
		head = _head;
		
		_headButtons = [];
	}
	
	var _view_headButtonsValid:Bool;
	var _titleTF:TextField;
	var _drawer:CVScale12GridDrawer;
	var _head:Sprite;
	
	override public function link(container:Sprite):Void 
	{
		super.link(container);
		_titleTF = MFormatFactory.WINDOW_TITLE.newAutoSized();
		_titleTF.mouseEnabled = false;
		addChild(_titleTF);
	}
	
	var _lineTop:Int;
	
	override function doValidateSize():Void
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			var titleWidth = Std.int(_titleTF.width);
			var titleHeight = Std.int(_titleTF.height);
			_titleTF.x = HINDENT;
			_titleTF.y = VINDENT;
			
			var buttonsWidth = 0;
			for (button in _headButtons)
			{
				var view = button.view;
				buttonsWidth += Std.int(view.width) + BUTTONS_INDENT;
			}
			buttonsWidth = CMath.intMax(0, buttonsWidth - BUTTONS_INDENT);
			
			var minWidth = titleWidth + buttonsWidth + HINDENT * 2;
			var minHeight = titleHeight + VINDENT * 2 + LINE_TOP_INDENT + LINE_BOTTOM_INDENT;
			var top = titleHeight + VINDENT + LINE_TOP_INDENT + LINE_BOTTOM_INDENT;
			var bottom = VINDENT;
			var left = VINDENT;
			var right = VINDENT;
			_container.width = CMath.intMax(0, getNeededWidth() - left - right);
			_container.height = CMath.intMax(0, getNeededHeight() - top - bottom);
			_width = CMath.intMax(Std.int(_container.width) + left + right, minWidth);
			_height = CMath.intMax(Std.int(_container.height) + top + bottom, minHeight);
			_container.x = left;
			_container.y = top;
			_lineTop = top - LINE_BOTTOM_INDENT;
			
			_view_valid = false;
			_view_headButtonsValid = false;
			postponeView();
		}
	}
	
	override function doValidateView():Void
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var format = _isLocked ?
				MFormatFactory.WINDOW_TITLE_DISABLED : MFormatFactory.WINDOW_TITLE;
			format.applyTo(_titleTF);
			
			var g = graphics;
			g.clear();
			
			g.lineStyle();
			var bd;
			if (_isLocked)
			{
				bd = MWindowBdFactory.getLockedTop();
			}
			else
			{
				bd = _isActive ? MWindowBdFactory.getActiveTop() : MWindowBdFactory.getDefaultTop();
			}
			g.beginBitmapFill(bd);
			g.drawRoundRectComplex(1, 1, width - 2, _lineTop - 1, 5, 5, 0, 0);
			g.endFill();
			
			_drawer.setBounds(
				0, 0, Std.int(_width + 2), Std.int(_height + 2), _lineTop + CENTER_TOP_OFFSET);
			_drawer.draw(g);
			
			var g = _head.graphics;
			g.clear();
			g.beginFill(0xffffff, 0);
			g.drawRect(0, 0, width, _lineTop);
			g.endFill();
		}
		if (!_view_headButtonsValid)
		{
			_view_headButtonsValid = true;
			
			var x = _width - BUTTONS_RIGHT;
			for (button in _headButtons)
			{
				var view = button.view;
				x -= view.width;
				view.x = x;
				view.y = 2;
				x -= BUTTONS_INDENT;
			}
		}
	}
	
	override function set_title(value:String) 
	{
		_title = value;
		_titleTF.text = _title;
		_size_valid = false;
		postponeSize();
		return _title;
	}
	
	override function updateIsLocked()
	{
		super.updateIsLocked();
		_view_valid = false;
		postponeView();
	}
	
	override function updateIsActive()
	{
		super.updateIsActive();
		_view_valid = false;
		postponeView();
	}
	
	private var _headButtons:Array<ICButton>;
	
	public function addHeadButton(button:ICButton):ICButton
	{
		_headButtons.remove(button);
		_headButtons.unshift(button);
		addChild(button.view);
		_size_valid = false;
		postponeSize();
		return button;
	}
	
	public var closeButton(get_closeButton, null):ICButton;
	var _closeButton:ICButton;
	function get_closeButton()
	{
		if (_closeButton == null)
		{
			_closeButton = new MCloseButton();
		}
		return _closeButton;
	}
	
	public var maximizeButton(get_maximizeButton, null):ICButton;
	var _maximizeButton:MMaximizeButton;
	function get_maximizeButton()
	{
		if (_maximizeButton == null)
		{
			_maximizeButton = new MMaximizeButton();
			_maximizeButton.toggle = true;
		}
		return _maximizeButton;
	}
	
	public function removeHeadButton(button:ICButton)
	{
		if (_headButtons.remove(button))
		{
			removeChild(button.view);
		}
	}
}