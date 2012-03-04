package temperate.minimal.graphics;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.geom.Matrix;
using temperate.core.CMath;
using temperate.core.CGraphicsUtil;

/**
 * There is only one reson to draw skin's BitmapData's by code for default skin:
 * - don't needed to include assets swf.
 * 
 * This is don't meen, that you mast write your release skins in code.
 * (In this case just incluse swf with you BitmapData's and customize components by they)
 */
class MCommonBdFactory 
{
	//----------------------------------------------------------------------------------------------
	//
	//  Customizing
	//
	//----------------------------------------------------------------------------------------------
	
	static var DEFAULT_WIDTH = 25;
	static var DEFAULT_HEIGHT = 50;
	static var DEFAULT_STRIAE_SIZE = 100;
	
	static var BOX_WIDTH = 20;
	static var BOX_HEIGHT = 14;
	
	public static var buttonBgColors:Array<UInt> =
		[ 0xff80e000, 0xff70a010, 0xff307000, 0xff50a000 ];
	public static var buttonBgSelectedColors:Array<UInt> =
		[ 0xfff09000, 0xffa09010, 0xff706000, 0xffa09000 ];
	public static var buttonBgRatios:Array<Int> = [ 0, 50, 51, 255 ];
	public static var buttonBgSelectedRatios:Array<Int> = [ 0, 50, 51, 255 ];
	public static var buttonShadowColor:UInt = 0x45000000;
	public static var buttonInnerBorderColor:UInt = 0x80ffffff;
	public static var buttonBorderColor:UInt = 0xaa105000;
	
	public static var roundBorderColors:Array<UInt> = [ 0xff000000, 0xff808080 ];
	public static var roundBorderRatios:Array<UInt> = [ 0, 255 ];
	public static var roundColorsUp:Array<UInt> = [ 0xffffffff, 0xffc0c0c0 ];
	public static var roundColorsDown:Array<UInt> = [ 0xffc0c0c0, 0xffffffff ];
	public static var roundRatiosUp:Array<UInt> = [ 0, 255 ];
	public static var roundRatiosDown:Array<UInt> = [ 0, 200 ];
	public static var roundBgColor:UInt = 0xff808080;
	public static var roundInnerLineColor:UInt = 0xd0ffffff;
	
	public static var textBgColor:UInt = 0xffffffff;
	public static var textBgColorInactive:UInt = 0xffeeeeee;
	public static var textBorderColor:UInt = 0xff808080;
	
	public static var arrowColorUp:UInt = 0xff308000;
	public static var arrowColorOver:UInt = 0xff50c000;
	
	//----------------------------------------------------------------------------------------------
	//
	//  Final bitmap data accessors
	//
	//----------------------------------------------------------------------------------------------
	
	//----------------------------------------------------------------------------------------------
	// Button
	//----------------------------------------------------------------------------------------------
	
	static var _buttonBgUp:BitmapData;

	public static function getButtonBgUp()
	{
		if (_buttonBgUp == null)
		{
			_buttonBgUp = newGradientBg(buttonBgColors, buttonBgRatios, true);
		}
		return _buttonBgUp;
	}
	
	static var _buttonBgDown:BitmapData;
	
	public static function getButtonBgDown()
	{
		if (_buttonBgDown == null)
		{
			_buttonBgDown = newGradientBg(buttonBgColors, buttonBgRatios, false);
		}
		return _buttonBgDown;
	}
	
	static var _buttonBgUpSelected:BitmapData;
	
	public static function getButtonBgUpSelected()
	{
		if (_buttonBgUpSelected == null)
		{
			_buttonBgUpSelected = newGradientBg(
				buttonBgSelectedColors, buttonBgSelectedRatios, true);
		}
		return _buttonBgUpSelected;
	}
	
	static var _buttonBgDownSelected:BitmapData;
	
	public static function getButtonBgDownSelected()
	{
		if (_buttonBgDownSelected == null)
		{
			_buttonBgDownSelected = newGradientBg(
				buttonBgSelectedColors, buttonBgSelectedRatios, false);
		}
		return _buttonBgDownSelected;
	}
	
	//----------------------------------------------------------------------------------------------
	// Check box
	//----------------------------------------------------------------------------------------------
	
	static var _checkBoxBgUp:BitmapData;
	
	public static function getCheckBoxBgUp()
	{
		if (_checkBoxBgUp == null)
		{
			_checkBoxBgUp = newEllipseBg(false, false);
		}
		return _checkBoxBgUp;
	}
	
	static var _checkBoxBgDown:BitmapData;
	
	public static function getCheckBoxBgDown()
	{
		if (_checkBoxBgDown == null)
		{
			_checkBoxBgDown = newEllipseBg(false, true);
		}
		return _checkBoxBgDown;
	}
	
	static var _checkBoxBgUpSelected:BitmapData;
	
	public static function getCheckBoxBgUpSelected()
	{
		if (_checkBoxBgUpSelected == null)
		{
			_checkBoxBgUpSelected = newEllipseBg(true, false);
		}
		return _checkBoxBgUpSelected;
	}
	
	static var _checkBoxBgDownSelected:BitmapData;
	
	public static function getCheckBoxBgDownSelected()
	{
		if (_checkBoxBgDownSelected == null)
		{
			_checkBoxBgDownSelected = newEllipseBg(true, true);
		}
		return _checkBoxBgDownSelected;
	}
	
	//----------------------------------------------------------------------------------------------
	// Radio button
	//----------------------------------------------------------------------------------------------
	
	static var _radioButtonBgUp:BitmapData;
	
	public static function getRadioButtonBgUp()
	{
		if (_radioButtonBgUp == null)
		{
			_radioButtonBgUp = newRoundBg(false, false);
		}
		return _radioButtonBgUp;
	}
	
	static var _radioButtonBgDown:BitmapData;
	
	public static function getRadioButtonBgDown()
	{
		if (_radioButtonBgDown == null)
		{
			_radioButtonBgDown = newRoundBg(false, true);
		}
		return _radioButtonBgDown;
	}
	
	static var _radioButtonBgUpSelected:BitmapData;
	
	public static function getRadioButtonBgUpSelected()
	{
		if (_radioButtonBgUpSelected == null)
		{
			_radioButtonBgUpSelected = newRoundBg(true, false);
		}
		return _radioButtonBgUpSelected;
	}
	
	static var _radioButtonBgDownSelected:BitmapData;
	
	public static function getRadioButtonBgDownSelected()
	{
		if (_radioButtonBgDownSelected == null)
		{
			_radioButtonBgDownSelected = newRoundBg(true, true);
		}
		return _radioButtonBgDownSelected;
	}
	
	//----------------------------------------------------------------------------------------------
	// Arrows
	//----------------------------------------------------------------------------------------------
	
	static var _upArrowUp:BitmapData;
	
	public static function getUpArrowUp()
	{
		if (_upArrowUp == null)
		{
			_upArrowUp = newArrow(false, true, arrowColorUp);
		}
		return _upArrowUp;
	}
	
	static var _upArrowOver:BitmapData;
	
	public static function getUpArrowOver()
	{
		if (_upArrowOver == null)
		{
			_upArrowOver = newArrow(false, true, arrowColorOver);
		}
		return _upArrowOver;
	}
	
	static var _downArrowUp:BitmapData;
	
	public static function getDownArrowUp()
	{
		if (_downArrowUp == null)
		{
			_downArrowUp = newArrow(false, false, arrowColorUp);
		}
		return _downArrowUp;
	}
	
	static var _downArrowOver:BitmapData;
	
	public static function getDownArrowOver()
	{
		if (_downArrowOver == null)
		{
			_downArrowOver = newArrow(false, false, arrowColorOver);
		}
		return _downArrowOver;
	}
	
	//----------------------------------------------------------------------------------------------
	// Text
	//----------------------------------------------------------------------------------------------
	
	static var _textBg:BitmapData;
	
	public static function getTextBg()
	{
		if (_textBg == null)
		{
			_textBg = newSimpleBg(textBgColor, textBorderColor);
		}
		return _textBg;
	}
	
	static var _textBgInactive:BitmapData;
	
	public static function getTextBgInactive()
	{
		if (_textBgInactive == null)
		{
			_textBgInactive = newSimpleBg(textBgColorInactive, textBorderColor);
		}
		return _textBgInactive;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Bitmap data customized generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newArrow(horizontal:Bool, left:Bool, color:UInt)
	{
		var arrow = MArrowBdFactory.newUpArrow(color);
		
		var width = horizontal ? 13 : 14;
		var height = horizontal ? 14 : 13;
		var bitmapData = new BitmapData(width, height, true, 0x00000000);
		var offsetX = (width - arrow.width) >> 1;
		var offsetY = (height - arrow.height) >> 1;
		var indent = 2;
		if (horizontal && left)
		{
			var tx = offsetY;
			var ty = offsetX + 1;
			bitmapData.draw(arrow, new Matrix(0, 1, 1, 0, tx, ty));
		}
		else if (horizontal && !left)
		{
			var tx = offsetY + arrow.height + 1;
			var ty = offsetX + 1;
			bitmapData.draw(arrow, new Matrix(0, 1, -1, 0, tx, ty));
		}
		else if (!horizontal && left)
		{
			var tx = offsetX;
			var ty = offsetY + indent;
			bitmapData.draw(arrow, new Matrix(1, 0, 0, 1, tx, ty));
		}
		else
		{
			var tx = offsetX;
			var ty = offsetY + arrow.height + 1 - indent;
			bitmapData.draw(arrow, new Matrix(1, 0, 0, -1, tx, ty));
		}
		return bitmapData;
	}
	
	static function newSimpleBg(fillColor:UInt, borderColor:UInt)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		g.drawRoundRectBorder(
			0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 6,
			borderColor.getColor(), borderColor.getAlpha(), 1);
		g.beginFill(fillColor.getColor(), fillColor.getAlpha());
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4);
		g.endFill();

		var bitmapData = new BitmapData(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, 0x0);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newGradientBg(colors:Array<UInt>, ratios:Array<Int>, shadow:Bool)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();

		var matrix = new Matrix();
		matrix.createGradientBox(DEFAULT_HEIGHT, DEFAULT_HEIGHT, Math.PI / 2);
		
		g.lineStyle();
		
		if (shadow)
		{
			g.drawRightBottomBorder(
				2, 2, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 4,
				buttonShadowColor.getColor(), buttonShadowColor.getAlpha(), 1, false);
		}
		
		g.drawRoundRectBorder(
			1, 1, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 4,
			buttonBorderColor.getColor(), buttonBorderColor.getAlpha(), 1);
		
		var alphas = [];
		var finalColors = [];
		MBdFactoryUtil.getColorsAndAlphas(colors, finalColors, alphas);
		
		g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 6);
		g.endFill();
		
		g.drawRoundRectBorder(
			2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4,
			buttonInnerBorderColor.getColor(), buttonInnerBorderColor.getAlpha(), 1);
		
		var bitmapData = new BitmapData(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, 0x00000000);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newEllipseBg(selected:Bool, down:Bool)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var matrix = new Matrix();
		matrix.createGradientBox(BOX_HEIGHT, BOX_HEIGHT, Math.PI / 2);

		var g = shape.graphics;
		g.clear();
		
		var width = BOX_WIDTH;
		var height = BOX_HEIGHT;
		var colors = [];
		var alphas = [];
		MBdFactoryUtil.getColorsAndAlphas(roundBorderColors, colors, alphas);
		
		{
			drawCircleRectBorder(
				g,
				1, 1, width - 2, height - 2,
				colors, alphas, roundBorderRatios, matrix, 1);
			g.beginFill(roundBgColor.getColor(), roundBgColor.getAlpha());
			g.drawRoundRect(2, 2, width - 4, height - 4, (width - 4) >> 1);
			g.endFill();
		}
			
		var colors = down ? roundColorsDown : roundColorsUp;
		var ratios = down ? roundRatiosDown : roundRatiosUp;
		var alphas = [];
		var finalColors = [];
		MBdFactoryUtil.getColorsAndAlphas(colors, finalColors, alphas);
		
		if (selected)
		{
			g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
			
			var r = (height >> 1) - 2;
			g.moveTo(2 + r, 2);
			g.lineTo(width - 2 - r - 1.5, 2);
			g.drawArc(width - 2 - r - 1.5, 2 + r, r, 1.5 * Math.PI, .5 * Math.PI);
			g.lineTo(2 + r, height - 2);
			g.drawArc(2 + r, 2 + r, r, .5 * Math.PI, 1.5 * Math.PI);
			
			g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
			g.drawRoundRect(
				2 + width - height, 2, height - 4, height - 4,
				(width - 4) * .5);
			g.endFill();
		}
		else
		{
			g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
			g.drawCircle(height >> 1, height >> 1, (height >> 1) - 2);
			g.endFill();
		}
		
		var offsetX = selected ? width - height : 0;
		g.drawCircleBorder(
			offsetX + (height >> 1), height >> 1, (height >> 1) - 2, 1,
			roundInnerLineColor.getColor(), roundInnerLineColor.getAlpha());
		
		var bitmapData = new BitmapData(width, height, true, 0x00000000);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function drawCircleRectBorder(
		g:Graphics,
		x:Float, y:Float, width:Float, height:Float,
		colors:Array<UInt>, alphas:Array<Float>, ratios:Array<UInt>, matrix:Matrix,
		thickness:Int):Void
	{
		var r = height * .5;
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.draw1per8SegmentBorder(2, 6, x + r, y + r, r, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.draw1per8SegmentBorder(-2, 2, x + width - r, y + r, r, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.drawRect(x + r, y, width - r * 2, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.drawRect(x + r, y + height - thickness, width - r * 2, thickness);
		g.endFill();
	}
	
	static function newRoundBg(selected:Bool, down:Bool)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var matrix = new Matrix();
		matrix.createGradientBox(BOX_HEIGHT, BOX_HEIGHT, Math.PI / 2);

		var g = shape.graphics;
		g.clear();
		
		var r = BOX_HEIGHT >> 1;
		var indent = down ? 3 : 4;
		
		{
			var colors = [];
			var alphas = [];
			MBdFactoryUtil.getColorsAndAlphas(roundBorderColors, colors, alphas);
			g.drawCircleGradientBorder(r, r, r - 1, 1, colors, alphas, roundBorderRatios, matrix);
			g.beginFill(roundBgColor.getColor(), roundBgColor.getAlpha());
			g.drawCircle(r, r, r - 2);
			g.endFill();
			if (selected)
			{
				g.drawCircleGradientBorder(
					r, r, r - 2, indent - 1, colors, alphas, roundBorderRatios, matrix);
			}
		}
		
		if (selected || down)
		{
			var alphas = [];
			var colors = [];
			MBdFactoryUtil.getColorsAndAlphas(
				down ? roundColorsDown : roundColorsUp, colors, alphas);
			var ratios = down ? roundRatiosDown : roundRatiosUp;
			g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			g.drawCircle(r, r, r - indent);
			g.endFill();
			
			g.drawCircleBorder(
				r, r, r - indent, 1,
				roundInnerLineColor.getColor(), roundInnerLineColor.getAlpha());
		}
		
		var bitmapData = new BitmapData(BOX_HEIGHT, BOX_HEIGHT, true, 0x00000000);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
}