package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.filters.BevelFilter;
import flash.filters.BitmapFilterType;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import temperate.components.CButtonState;
using temperate.core.CMath;

class MWindowBdFactory 
{
	static var DEFAULT_STRIAE_SIZE = 20;
	static var MAX_HEAD_HEIGHT = 50;
	
	public static inline var FRAME_CENTER_TOP = 30;
	
	public static var gradientHeight = 24;
	public static var striaeColor:UInt = 0x80ffffff;
	public static var striaeBgColor:UInt = 0x00ffffff;
	public static var headTopColor:UInt = 0xf8407015;
	public static var headBottomColor:UInt = 0xe080c030;
	public static var headTopActiveColor:UInt = 0xf8508000;
	public static var headBottomActiveColor:UInt = 0xe0a0e020;
	public static var headTopLockedColor:UInt = 0xf0808080;
	public static var headBottomLockedColor:UInt = 0xf0cccccc;
	
	static function newStriae(color:UInt, bgColor:UInt, space:Int, size:Int)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		g.lineStyle(size, color.getColor(), color.getAlpha());
		var x = -DEFAULT_STRIAE_SIZE;
		while (x < DEFAULT_STRIAE_SIZE)
		{
			g.moveTo(x + DEFAULT_STRIAE_SIZE, 0);
			g.lineTo(x, DEFAULT_STRIAE_SIZE);
			x += space + size;
		}
		
		var bitmapData = new BitmapData(
			DEFAULT_STRIAE_SIZE, DEFAULT_STRIAE_SIZE, true, bgColor);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newFrame(width:Int, height:Int, lineTop:Int)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		g.beginFill(0x000000, .2);
		g.drawRoundRect(2, 2, width, height, 12);
		g.drawRoundRect(2, 2, width - 2, height - 2, 12);
		g.endFill();
		
		g.beginFill(0x505050);
		g.drawRoundRect(0, 0, width, height, 12);
		g.drawRoundRect(1, 1, width - 2, height - 2, 10);
		
		g.lineStyle();
		
		g.beginFill(0xeeeeee);
		g.drawRoundRectComplex(1, lineTop, width - 2, height - lineTop - 1, 0, 0, 5, 5);
		g.endFill();
		
		g.beginFill(0xffffff);
		g.drawRoundRectComplex(1, lineTop, width - 2, height - lineTop - 1, 0, 0, 5, 5);
		g.drawRoundRectComplex(1, lineTop, width - 3, height - lineTop - 2, 0, 0, 5, 5);
		g.endFill();
		
		var matrix = new Matrix();
		matrix.createGradientBox(10, lineTop, Math.PI * .5);
		
		g.beginGradientFill(
			GradientType.LINEAR, [0xffffff, 0xffffff], [.5, 1], [0, 255], matrix);
		g.drawRoundRectComplex(1, 1, width - 2, lineTop - 1, 5, 5, 0, 0);
		g.drawRoundRectComplex(2, 2, width - 4, lineTop - 2, 5, 5, 0, 0);
		g.endFill();
		
		g.beginFill(0xffffff, .6);
		g.drawRect(2, lineTop - 2, width - 4, 1);
		g.endFill();
		g.beginFill(0x000000, .2);
		g.drawRect(2, lineTop - 1, width - 4, 1);
		g.endFill();
		
		var bd = new BitmapData(width + 2, height + 2, true, 0x00000000);
		bd.draw(shape);
		MBdFactoryUtil.qualityOff();
		return bd;
	}
	
	static function newTop(striae:BitmapData, topColor:UInt, bottomColor:UInt)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		var width = striae.width;
		
		var matrix = new Matrix();
		matrix.createGradientBox(10, gradientHeight, Math.PI * .5);
		g.beginGradientFill(
			GradientType.LINEAR,
			[topColor.getColor(), bottomColor.getColor()],
			[topColor.getAlpha(), bottomColor.getAlpha()],
			[0, 255], matrix);
		g.drawRect(0, 0, width, MAX_HEAD_HEIGHT);
		g.endFill();
		
		g.beginBitmapFill(striae);
		g.drawRect(0, 0, width, MAX_HEAD_HEIGHT);
		g.endFill();
		
		var bd = new BitmapData(width, MAX_HEAD_HEIGHT, true, 0x000000);
		bd.draw(shape);
		MBdFactoryUtil.qualityOff();
		return bd;
	}
	
	static var _defaultStriae:BitmapData;
	
	static function getDefaultStriae():BitmapData
	{
		if (_defaultStriae == null)
		{
			_defaultStriae = newStriae(striaeColor, striaeBgColor, 4, 1);
		}
		return _defaultStriae;
	}
	
	static var _frame:BitmapData;
	
	public static function getFrame():BitmapData
	{
		if (_frame == null)
		{
			_frame = newFrame(100, 100, FRAME_CENTER_TOP);
		}
		return _frame;
	}
	
	static var _defaultTop:BitmapData;
	
	public static function getDefaultTop():BitmapData
	{
		if (_defaultTop == null)
		{
			_defaultTop = newTop(getDefaultStriae(), headTopColor, headBottomColor);
		}
		return _defaultTop;
	}
	
	static var _lockedTop:BitmapData;
	
	public static function getLockedTop():BitmapData
	{
		if (_lockedTop == null)
		{
			_lockedTop = newTop(getDefaultStriae(), headTopLockedColor, headBottomLockedColor);
		}
		return _lockedTop;
	}
	
	static var _activeTop:BitmapData;
	
	public static function getActiveTop():BitmapData
	{
		if (_activeTop == null)
		{
			_activeTop = newTop(getDefaultStriae(), headTopActiveColor, headBottomActiveColor);
		}
		return _activeTop;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Images
	//
	//----------------------------------------------------------------------------------------------
	
	public static var imageSize:Int = 12;
	public static var imageHorizontalIndent:Int = 2;
	public static var imageVerticalIndent:Int = 6;
	
	static function newImageBitmapData()
	{
		return new BitmapData(
			imageSize + imageHorizontalIndent * 2,
			imageSize + imageVerticalIndent * 2,
			true,
			0x00000000);
	}
	
	static function getImageOffsetMatrix()
	{
		return new Matrix(1, 0, 0, 1, imageHorizontalIndent, imageVerticalIndent);
	}
	
	static var _imageClose:Array<BitmapData>;
	public static function getImageClose(state:CButtonState):BitmapData
	{
		if (_imageClose == null)
		{
			_imageClose = [];
		}
		var image = _imageClose[state.index];
		if (image == null)
		{
			image = newImageBitmapData();
			_imageClose[state.index] = image;
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			var halfWidth = 2;
			g.beginFill(0xffffff);
			g.moveTo(0, 0);
			g.lineTo(halfWidth, 0);
			g.lineTo(imageSize, imageSize - halfWidth);
			g.lineTo(imageSize, imageSize);
			g.lineTo(imageSize - halfWidth, imageSize);
			g.lineTo(0, halfWidth);
			g.lineTo(0, 0);
			g.endFill();
			g.beginFill(0xffffff);
			g.moveTo(imageSize, 0);
			g.lineTo(imageSize, halfWidth);
			g.lineTo(halfWidth, imageSize);
			g.lineTo(0, imageSize);
			g.lineTo(0, imageSize - halfWidth);
			g.lineTo(imageSize - halfWidth, 0);
			g.lineTo(imageSize, 0);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			image.draw(shape, getImageOffsetMatrix());
			image.applyFilter(image, image.rect, new Point(), new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return image;
	}
	
	static var _imageMinimize:Array<BitmapData>;
	public static function getImageMinimize(state:CButtonState):BitmapData
	{
		if (_imageMinimize == null)
		{
			_imageMinimize = [];
		}
		var image = _imageMinimize[state.index];
		if (image == null)
		{
			image = newImageBitmapData();
			_imageMinimize[state.index] = image;
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.drawRect(0, imageSize - 3, imageSize, 3);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			image.draw(shape, getImageOffsetMatrix());
			image.applyFilter(image, image.rect, new Point(), new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return image;
	}
	
	static var _imageMaximize:Array<BitmapData>;
	public static function getImageMaximize(state:CButtonState):BitmapData
	{
		if (_imageMaximize == null)
		{
			_imageMaximize = [];
		}
		var image = _imageMaximize[state.index];
		if (image == null)
		{
			image = newImageBitmapData();
			_imageMaximize[state.index] = image;
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.drawRect(0, 0, imageSize, imageSize);
			g.drawRect(2, 3, imageSize - 4, imageSize - 5);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			image.draw(shape, getImageOffsetMatrix());
			image.applyFilter(image, image.rect, new Point(), new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return image;
	}
	
	static var _imageCollapse:Array<BitmapData>;
	public static function getImageCollapse(state:CButtonState):BitmapData
	{
		if (_imageCollapse == null)
		{
			_imageCollapse = [];
		}
		var image = _imageCollapse[state.index];
		if (image == null)
		{
			image = newImageBitmapData();
			_imageCollapse[state.index] = image;
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.drawRect(3, 0, imageSize - 3, imageSize - 4);
			g.drawRect(3, 3, imageSize - 5, imageSize - 7);
			g.endFill();
			g.beginFill(0xffffff);
			g.drawRect(0, 4, imageSize - 3, imageSize - 4);
			g.drawRect(2, 7, imageSize - 7, imageSize - 9);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			image.draw(shape, getImageOffsetMatrix());
			image.applyFilter(image, image.rect, new Point(), new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return image;
	}
}