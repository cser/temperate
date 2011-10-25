package temperate.minimal.renderers;
import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import temperate.core.CMath;
import temperate.tooltips.CGeomUtil;

class MTooltipBg extends Sprite
{
	public function new() 
	{
		super();
		
		borderRadius = 8;
		borderThickness = 1;
		tailIndent = -4;
		tailHalfWidth = 6;
		fillColor = 0xffffffe0;
		borderColor = 0xff808080;
		
		blendMode = BlendMode.LAYER;
		
		_mask = new Shape();
		_mask.blendMode = BlendMode.ERASE;
		addChild(_mask);
		
		_top = new Sprite();
		_top.blendMode = BlendMode.LAYER;
		addChild(_top);
		
		_topRect = new Shape();
		_top.addChild(_topRect);
		
		_topTail = new Shape();
		_top.addChild(_topTail);
	}
	
	var _mask:Shape;
	var _top:Sprite;
	var _topRect:Shape;
	var _topTail:Shape;
	
	public var borderRadius:Int;
	
	public var borderThickness:Int;
	
	public var tailIndent:Int;
	
	public var tailHalfWidth:Int;
	
	public var fillColor:UInt;
	
	public var borderColor:UInt;
	
	var _tailBeginX:Float;
	var _tailBeginY:Float;
	var _tailEndX:Float;
	var _tailEndY:Float;
	var _width:Float;
	var _height:Float;
	
	public function redraw(width:Float, height:Float, target:Rectangle):Void
	{
		_width = width;
		_height = height;
		
		var centerX = _width * .5;
		var centerY = _height * .5;
		var targetCenterX = target.x + target.width * .5;
		var targetCenterY = target.y + target.height * .5;
		
		CGeomUtil.getNearestRectCross(
			targetCenterX, targetCenterY,
			centerX, centerY,
			tailHalfWidth + 1, tailHalfWidth + 1,
			_width - tailHalfWidth * 2 - 2, _height - tailHalfWidth * 2 - 2,
			0
		);
		_tailBeginX = CGeomUtil.crossX;
		_tailBeginY = CGeomUtil.crossY;
		
		CGeomUtil.getNearestRectCross(
			centerX, centerY,
			targetCenterX, targetCenterY,
			target.x, target.y, target.width, target.height,
			tailIndent
		);
		_tailEndX = CGeomUtil.crossX;
		_tailEndY = CGeomUtil.crossY;
		
		drawShape(graphics, graphics, borderColor, true, true);
		drawShape(_mask.graphics, _mask.graphics, 0xffffff, false, false);
		drawShape(_topRect.graphics, _topTail.graphics, fillColor, false, false);
		_top.alpha = CMath.alphaPart(fillColor);
	}
	
	function drawShape(rect:Graphics, tail:Graphics, color:UInt, needDrawBorder:Bool, useAlpha:Bool)
	{
		tail.clear();
		if (needDrawBorder)
		{
			tail.lineStyle(
				borderThickness * 2, CMath.colorPart(color), CMath.alphaPart(color));
		}
		
		var dx = _tailEndX - _tailBeginX;
		var dy = _tailEndY - _tailBeginY;
		var a = Math.sqrt(dx * dx + dy * dy);
		
		if (a > 1)
		{
			var cos = dx / a;
			var sin = dy / a;
			tail.moveTo(_tailBeginX - tailHalfWidth * sin, _tailBeginY + tailHalfWidth * cos);
			tail.beginFill(CMath.colorPart(color), useAlpha ? CMath.alphaPart(color) : 1);
			tail.lineTo(_tailEndX, _tailEndY);
			tail.lineTo(_tailBeginX + tailHalfWidth * sin, _tailBeginY - tailHalfWidth * cos);
			tail.endFill();
		}
		
		if (rect != tail)
		{
			rect.clear();
			if (needDrawBorder)
			{
				rect.lineStyle(
					borderThickness * 2, CMath.colorPart(color), CMath.alphaPart(color));
			}
		}
		rect.beginFill(CMath.colorPart(color), useAlpha ? CMath.alphaPart(color) : 1);
		rect.drawRoundRect(
			borderThickness, borderThickness,
			_width - borderThickness * 2,_height - borderThickness * 2,
			borderRadius * 2
		);
		rect.endFill();
	}
	
	function getMinPositive(k0:Float, k1:Float, k2:Float, k3:Float)
	{
		var k = Math.POSITIVE_INFINITY;
		if (k0 > 0)
		{
			k = k0;
		}
		if (k1 > 0 && k1 < k)
		{
			k = k1;
		}
		if (k2 > 0 && k2 < k)
		{
			k = k2;
		}
		if (k3 > 0 && k3 < k)
		{
			k = k3;
		}
		return k == Math.POSITIVE_INFINITY ? 0 : k;
	}
}