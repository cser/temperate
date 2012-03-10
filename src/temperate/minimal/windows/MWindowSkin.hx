package temperate.minimal.windows;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.text.TextField;
import temperate.components.ICButton;
import temperate.core.CMath;
import temperate.layouts.parametrization.CChildWrapper;
import temperate.minimal.graphics.MWindowBdFactory;
import temperate.minimal.MFormatFactory;
import temperate.minimal.windows.MCloseButton;
import temperate.minimal.windows.MMaximizeButton;
import temperate.raster.CVScale12GridDrawer;
import temperate.windows.skins.ACWindowSkin;
using temperate.core.ArrayUtil;
using temperate.core.CGraphicsUtil;

class MWindowSkin extends ACWindowSkin
{
	static var INDENT = 4;
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
	var _measuredTF:TextField;
	var _titleTF:TextField;
	var _drawer:CVScale12GridDrawer;
	var _head:Sprite;
	
	override public function link(container:Sprite, wrapper:CChildWrapper):Void 
	{
		super.link(container, wrapper);
		var format = MFormatFactory.WINDOW_TITLE;
		_measuredTF = format.newAutoSized();
		_measuredTF.text = " ";
		_titleTF = format.newFixed();
		_titleTF.mouseEnabled = false;
		_titleTF.x = INDENT;
		_titleTF.y = INDENT;
		addChild(_titleTF);
	}
	
	var _lineTop:Int;
	
	override function doValidateSize():Void
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			var titleWidth = Std.int(_measuredTF.width);
			var titleHeight = Std.int(_measuredTF.height);
			_titleTF.width = titleWidth;
			_titleTF.height = titleHeight;
			
			var buttonsWidth = 0;
			for (button in _headButtons)
			{
				var view = button.view;
				buttonsWidth += Std.int(view.width) + BUTTONS_INDENT;
			}
			buttonsWidth = CMath.intMax(0, buttonsWidth - BUTTONS_INDENT);
			
			var minWidth = titleWidth + buttonsWidth + INDENT * 2;
			var minHeight = titleHeight + INDENT * 2 + LINE_TOP_INDENT + LINE_BOTTOM_INDENT;
			var top = titleHeight + INDENT + LINE_TOP_INDENT + LINE_BOTTOM_INDENT;
			var bottom = INDENT;
			var left = INDENT;
			var right = INDENT;
			var neededWidth = CMath.intMax(getNeededWidth(), minWidth);
			_wrapper.x = 0;
			_wrapper.y = 0;
			if (!Math.isNaN(_wrapper.widthPortion))
			{
				_wrapper.setWidth(CMath.intMax(0, neededWidth - left - right));
			}
			if (!Math.isNaN(_wrapper.heightPortion))
			{
				_wrapper.setHeight(CMath.intMax(0, getNeededHeight() - top - bottom));
			}
			_width = CMath.intMax(Std.int(_wrapper.getWidth()) + left + right, minWidth);
			_height = CMath.intMax(Std.int(_wrapper.getHeight()) + top + bottom, minHeight);
			_wrapper.updatePosition(left, top);
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
			
			var format = _isEnabled ?
				MFormatFactory.WINDOW_TITLE : MFormatFactory.WINDOW_TITLE_DISABLED;
			format.applyTo(_titleTF);
			
			var g = _head.graphics;
			g.clear();
			var bd;
			if (_isEnabled)
			{
				bd = _isActive ? MWindowBdFactory.getActiveTop() : MWindowBdFactory.getDefaultTop();
			}
			else
			{
				bd = MWindowBdFactory.getLockedTop();
			}
			{
				var w = bd.width;
				var w2 = bd.width >> 1;
				g.beginBitmapFill(bd);
				g.drawRoundRectComplexStepByStep(2, 2, w - 2, _lineTop - 4, 5, 0, 0, 0);
				g.endFill();
				var x0 = w;
				var x1 = _width - w2;
				var lastI = Std.int((x1 - x0) / w);
				var i = lastI;
				if (x1 - x0 - i * w > 0)
				{
					g.beginBitmapFill(bd, new Matrix(1, 0, 0, 1, x0 + i * w), false);
					g.drawRect(x0 + i * w, 2, x1 - x0 - i * w, _lineTop - 4);
					g.endFill();
				}
				while (i-- > 0)
				{
					g.beginBitmapFill(bd, new Matrix(1, 0, 0, 1, x0 + i * w), false);
					g.drawRect(x0 + i * w, 2, w, _lineTop - 4);
					g.endFill();
				}
				var offset = Std.int((_width - w2 - x0 - lastI * w) / w2) * w2;
				g.beginBitmapFill(bd, new Matrix(1, 0, 0, 1, x0 + lastI * w + offset), false);
				g.drawRoundRectComplexStepByStep(_width - w2, 2, w2 - 2, _lineTop - 4, 0, 5, 0, 0);
				g.endFill();
			}
			
			graphics.clear();
			_drawer.setBounds(
				0, 0, Std.int(_width + 2), Std.int(_height + 2), _lineTop + CENTER_TOP_OFFSET);
			_drawer.draw(graphics);
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
		var corrected = _title != null && _title != "" ? _title : " ";
		_measuredTF.text = corrected;
		_titleTF.text = corrected;
		_size_valid = false;
		postponeSize();
		return _title;
	}
	
	override function updateIsEnabled()
	{
		super.updateIsEnabled();
		_view_valid = false;
		postponeView();
	}
	
	override function updateIsActive()
	{
		super.updateIsActive();
		_view_valid = false;
		postponeView();
	}
	
	var _headButtons:Array<ICButton>;
	
	public function addHeadButton(button:ICButton):ICButton
	{
		_headButtons.remove(button);
		_headButtons.unshift(button);
		addChild(button.view);
		_size_valid = false;
		postponeSize();
		return button;
	}
	
	public function removeHeadButton(button:ICButton):Void
	{
		if (_headButtons.remove(button))
		{
			removeChild(button.view);
			_size_valid = false;
			postponeSize();
		}
	}
	
	public function existsHeadButton(button:ICButton):Bool
	{
		return _headButtons.exists(button);
	}
	
	var _closeButton:ICButton;
	
	public function getCloseButton():ICButton
	{
		if (_closeButton == null)
		{
			_closeButton = new MCloseButton();
		}
		return _closeButton;
	}
	
	var _maximizeButton:MMaximizeButton;
	
	public function getMaximizeButton():ICButton
	{
		if (_maximizeButton == null)
		{
			_maximizeButton = new MMaximizeButton();
			_maximizeButton.toggle = true;
		}
		return _maximizeButton;
	}
}