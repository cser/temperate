package temperate.minimal.skins;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.text.TextField;
import temperate.core.CMath;
import temperate.minimal.graphics.MWindowBdFactory;
import temperate.minimal.MFormatFactory;
import temperate.skins.ACWindowSkin;

class MWindowSkin extends ACWindowSkin
{
	static var HINDENT = 4;
	static var VINDENT = 4;
	static var LINE_TOP_INDENT = 2;
	static var LINE_BOTTOM_INDENT = 4;
	
	public function new() 
	{
		super();
	}
	
	var _titleTF:TextField;
	
	override public function link(container:Sprite):Void 
	{
		super.link(container);
		_titleTF = MFormatFactory.WINDOW_TITLE.newAutoSized();
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
			var minWidth = titleWidth + HINDENT * 2;
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
			postponeView();
		}
	}
	
	override function doValidateView():Void
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var g = graphics;
			
			g.clear();
			
			g.beginFill(0x000000, .2);
			g.drawRoundRect(3, 3, width, height, 12);
			g.drawRoundRect(3, 3, width - 3, height - 3, 12);
			g.endFill();
			
			g.lineStyle(2, 0x505050);
			g.drawRoundRect(0, 0, width, height, 10);
			
			g.lineStyle();
			
			g.beginFill(0xeeeeee);
			g.drawRoundRect(0, 0, width, height, 10);
			g.endFill();
			
			g.lineStyle();
			g.beginFill(0xffffff);
			g.drawRoundRect(0, 0, width, height, 10);
			g.drawRoundRect(0, 0, width - 1, height - 1, 10);
			g.endFill();
			
			var matrix = new Matrix();
			matrix.createGradientBox(10, _lineTop, Math.PI * .5);
			g.lineStyle();
			g.beginGradientFill(
				GradientType.LINEAR, [0x508000, 0xa0e020], [1, 1], [0, 255], matrix);
			g.drawRoundRectComplex(0, 0, width, _lineTop, 5, 5, 0, 0);
			g.endFill();
			
			g.lineStyle();
			g.beginBitmapFill(MWindowBdFactory.getDefaultStriae());
			g.drawRoundRectComplex(0, 0, width, _lineTop - 2, 5, 5, 0, 0);
			g.endFill();
			
			g.lineStyle();
			g.beginGradientFill(
				GradientType.LINEAR, [0xffffff, 0xffffff], [.5, 1], [0, 255], matrix);
			g.drawRoundRectComplex(0, 0, width, _lineTop, 5, 5, 0, 0);
			g.drawRoundRectComplex(1, 1, width - 2, _lineTop - 1, 5, 5, 0, 0);
			g.endFill();
			
			g.lineStyle();
			g.beginFill(0xffffff, .6);
			g.drawRect(1, _lineTop - 2, width - 2, 1);
			g.endFill();
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
}