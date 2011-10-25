package temperate.minimal.graphics;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.Matrix;
import temperate.core.CMath;

/**
 * There is only one reson to draw skin's BitmapData's by code for default skin:
 * - don't needed to include assets swf.
 * 
 * This is don't meen, that you mast write your release skins in code.
 * (In this case just incluse swf with you BitmapData's and customize components by they)
 */
class MCommonBdFactory 
{	
	/*
	static function newStriae(color:UInt, backgroundColor:UInt, space:Int, size:Int)
	{
		var g = shape.graphics;
		g.clear();
		
		g.lineStyle(size, color);
		var x = -DEFAULT_STRIAE_SIZE;
		while (x < DEFAULT_STRIAE_SIZE)
		{
			g.moveTo(x + DEFAULT_STRIAE_SIZE, 0);
			g.lineTo(x, DEFAULT_STRIAE_SIZE);
			x += space + size;
		}
		
		var bitmapData = new BitmapData(
			DEFAULT_STRIAE_SIZE, DEFAULT_STRIAE_SIZE, false, backgroundColor);
		bitmapData.draw(shape);
		return bitmapData;
	}
	
	public static function getPanelStriae()
	{
		return newStriae(0xc0c0c0, 0xd0d0d0, 3, 1);
	}
	*/
	
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
	public static var buttonBorderColor:UInt = 0xff105000;
	
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

		g.beginFill(CMath.colorPart(borderColor), CMath.alphaPart(borderColor));
		g.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 6);
		g.drawRoundRect(1, 1, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 4);
		g.endFill();
		g.beginFill(CMath.colorPart(fillColor), CMath.alphaPart(fillColor));
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
			g.beginFill(CMath.colorPart(buttonShadowColor), CMath.alphaPart(buttonShadowColor));
			g.drawRoundRect(2, 2, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 8);
			g.drawRoundRect(1, 1, DEFAULT_WIDTH - 3, DEFAULT_HEIGHT - 3, 8);
			g.endFill();
		}
		
		g.beginFill(CMath.colorPart(buttonBorderColor), CMath.alphaPart(buttonInnerBorderColor));
		g.drawRoundRect(1, 1, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 8);
		g.drawRoundRect(3, 3, DEFAULT_WIDTH - 6, DEFAULT_HEIGHT - 6, 4);
		g.endFill();
		
		var alphas = [];
		var finalColors = [];
		MBdFactoryUtil.getColorsAndAlphas(colors, finalColors, alphas);
		
		g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 8);
		g.endFill();
		
		g.beginFill(
			CMath.colorPart(buttonInnerBorderColor), CMath.alphaPart(buttonInnerBorderColor));
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4);
		g.drawRoundRect(3, 3, DEFAULT_WIDTH - 6, DEFAULT_HEIGHT - 6, 6);
		g.endFill();

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
		
		var colors = [];
		var alphas = [];
		MBdFactoryUtil.getColorsAndAlphas(roundBorderColors, colors, alphas);
		
		{
			var width = BOX_WIDTH;
			var height = BOX_HEIGHT;
			
			g.beginGradientFill(GradientType.LINEAR, colors, alphas, roundBorderRatios, matrix);
			g.drawRoundRect(1, 1, width - 2, height - 2, (width - 0) >> 1);
			g.drawRoundRect(2, 2, width - 4, height - 4, (width - 4) >> 1);
			g.endFill();
			
			g.beginFill(CMath.colorPart(roundBgColor), CMath.alphaPart(roundBgColor));
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
			g.drawRoundRect(
				2, 2, BOX_WIDTH - 4, BOX_HEIGHT - 4,
				(BOX_HEIGHT - 2) >> 1);
			g.drawRoundRect(
				2 + BOX_WIDTH - BOX_HEIGHT - 1, 2, BOX_HEIGHT - 4 + 1, BOX_HEIGHT - 4,
				(BOX_HEIGHT - 4) >> 1);
			g.endFill();
			
			g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
			g.drawRoundRect(
				2 + BOX_WIDTH - BOX_HEIGHT, 2, BOX_HEIGHT - 4, BOX_HEIGHT - 4,
				(BOX_WIDTH - 4) * .5);
			g.endFill();
		}
		else
		{
			g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
			g.drawEllipse(2, 2, BOX_HEIGHT - 4, BOX_HEIGHT - 4);
			g.endFill();
		}
		
		var offsetX = selected ? BOX_WIDTH - BOX_HEIGHT : 0;
		g.beginFill(CMath.colorPart(roundInnerLineColor), CMath.alphaPart(roundInnerLineColor));
		g.drawEllipse(2 + offsetX, 2, BOX_HEIGHT - 4, BOX_HEIGHT - 4);
		g.drawEllipse(3 + offsetX, 3, BOX_HEIGHT - 6, BOX_HEIGHT - 6);
		g.endFill();
		
		var bitmapData = new BitmapData(BOX_WIDTH, BOX_HEIGHT, true, 0x00000000);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newRoundBg(selected:Bool, down:Bool)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var matrix = new Matrix();
		matrix.createGradientBox(BOX_HEIGHT, BOX_HEIGHT, Math.PI / 2);

		var g = shape.graphics;
		g.clear();
		
		var indent = down ? 3 : 4;
		
		{
			var width = BOX_HEIGHT;
			var height = BOX_HEIGHT;
			
			var colors = [];
			var alphas = [];
			MBdFactoryUtil.getColorsAndAlphas(roundBorderColors, colors, alphas);
			
			g.beginGradientFill(GradientType.LINEAR, colors, alphas, roundBorderRatios, matrix);
			g.drawEllipse(1, 1, width - 2, height - 2);
			g.drawEllipse(2, 2, width - 4, height - 4);
			g.endFill();
			
			g.beginFill(CMath.colorPart(roundBgColor), CMath.alphaPart(roundBgColor));
			g.drawEllipse(2, 2, width - 4, height - 4);
			g.endFill();
			
			if (selected)
			{
				g.beginGradientFill(GradientType.LINEAR, colors, alphas, roundBorderRatios, matrix);
				g.drawEllipse(
					indent - 1, indent - 1, width - indent * 2 + 2, height - indent * 2 + 2);
				g.drawEllipse(2, 2, width - 4, height - 4);
				g.endFill();
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
			g.drawEllipse(indent, indent, BOX_HEIGHT - indent * 2, BOX_HEIGHT - indent * 2);
			g.endFill();
			
			g.beginFill(CMath.colorPart(roundInnerLineColor), CMath.alphaPart(roundInnerLineColor));
			g.drawEllipse(indent, indent, BOX_HEIGHT - indent * 2, BOX_HEIGHT - indent * 2);
			g.drawEllipse(
			indent + 1, indent + 1, BOX_HEIGHT - indent * 2 - 2, BOX_HEIGHT - indent * 2 - 2);
			g.endFill();
		}
		
		var bitmapData = new BitmapData(BOX_HEIGHT, BOX_HEIGHT, true, 0x00000000);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
}