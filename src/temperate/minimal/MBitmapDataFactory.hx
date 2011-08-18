package temperate.minimal;

import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.StageQuality;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;
import temperate.core.CMath;

/**
 * There is only one reson to draw skin's BitmapData's by code for default skin:
 * - don't needed to include assets swf.
 * 
 * This is don't meen, that you mast write your release skins in code.
 * (In this case just incluse swf with you BitmapData's and customize components by they)
 */
class MBitmapDataFactory 
{	
	/*
	static var _knockoutShape:BitmapData;

	public static function getKnockoutShape()
	{
		if (_knockoutShape == null)
		{
			var innerStrength = 1.7;
			var outerStrength = 1.5;
			
			var g = _shape.graphics;
			g.clear();
			
			g.beginFill(outerGlowColor, .1);
			g.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 8);
			g.drawRoundRect(1, 1, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 6);
			g.endFill();
			
			g.beginFill(outerGlowColor, .5);
			g.drawRoundRect(1, 1, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 6);
			g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4);
			g.endFill();
			
			g.beginFill(innerGlowColor, .5);
			g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4);
			g.drawRoundRect(4, 4, DEFAULT_WIDTH - 8, DEFAULT_HEIGHT - 8, 4);
			g.endFill();
			
			_knockoutShape = new BitmapData(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, 0x0);
			_knockoutShape.draw(_shape);
		}
		return _knockoutShape;
	}

	static function newStriae(color:UInt, backgroundColor:UInt, space:Int, size:Int)
	{
		var g = _shape.graphics;
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
		bitmapData.draw(_shape);
		return bitmapData;
	}
	
	public static function getPanelStriae()
	{
		return newStriae(0xc0c0c0, 0xd0d0d0, 3, 1);
	}
	
	static var ROUND_SIZE = 18;
	
	public static function newToggleShape(isRound:Bool, enabled:Bool)
	{
		var innerStrength = 1.7;
		var outerStrength = .5;

		var g = _shape.graphics;
		g.clear();
		
		var halfRoundSize = ROUND_SIZE >> 1;
		
		g.beginFill(enabled ? textBgColor : textBgColorDisabled);
		if (isRound)
		{
			g.drawCircle(halfRoundSize, halfRoundSize, halfRoundSize - 3);
		}
		else
		{
			g.drawRect(2, 2, ROUND_SIZE - 4, ROUND_SIZE - 4);
		}
		g.endFill();
		
		var bitmapData:BitmapData = new BitmapData(ROUND_SIZE, ROUND_SIZE, true, 0x0);
		bitmapData.draw(_shape);
		bitmapData.applyFilter(
			bitmapData, bitmapData.rect, new Point(),
			new GlowFilter(
				textInnerGlowColor, 1, 2, 2, innerStrength, BitmapFilterQuality.HIGH, true)
		);
		bitmapData.applyFilter(
			bitmapData, bitmapData.rect, new Point(),
			new GlowFilter(textOuterGlowColor, 1, 3, 3, outerStrength, BitmapFilterQuality.HIGH));
		return bitmapData;
	}

	static function newScrollBg(down:Bool)
	{
		var defaultScrollThickness = 18;
		
		var g = _shape.graphics;
		g.clear();
		
		g.beginFill(down ? 0xc0c0c0 : 0xa1a1a1);
		g.drawRect(0, 0, DEFAULT_WIDTH, defaultScrollThickness);
		g.endFill();
		g.lineStyle(1, 0x8f8f8f);
		var y = 0;
		while (y <= defaultScrollThickness)
		{
			g.moveTo(0, y);
			g.lineTo(DEFAULT_WIDTH, y);
			y += 2;
		}
		
		var bitmapData = new BitmapData(DEFAULT_WIDTH, defaultScrollThickness, true, 0x00efefef);
		bitmapData.draw(_shape);
		return bitmapData;
	}
	
	private static var _scrollBgUp:BitmapData;
	
	public static function getScrollBgUp()
	{
		if (_scrollBgUp == null)
		{
			_scrollBgUp = newScrollBg(false);
		}
		return _scrollBgUp;
	}
	
	private static var _scrollBgDown:BitmapData;

	public static function getScrollBgDown()
	{
		if (_scrollBgDown == null)
		{
			_scrollBgDown = newScrollBg(true);
		}
		return _scrollBgDown;
	}
	
	private var _thumbIcon:BitmapData;

	public function getThumbIcon()
	{
		if (_thumbIcon == null)
		{
			var defaultScrollThickness = 18;
			
			var g = _shape.graphics;
			g.clear();
			
			for (i in 0 ... 4)
			{
				g.beginFill(0x000000, .4);
				g.drawRect(2 + i * 3, 3, 2, defaultScrollThickness - 6);
				g.endFill();
			}
			
			var innerStrength = 1.7;
			
			_thumbIcon = new BitmapData(
				defaultScrollThickness - 4, defaultScrollThickness - 2, true, 0x00efefef);
			_thumbIcon.draw(_shape);
			_thumbIcon.applyFilter(
				_thumbIcon, _thumbIcon.rect, new Point(),
				new GlowFilter(0xffffff, 1, 2, 2, innerStrength, BitmapFilterQuality.HIGH)
			);
		}
		return _thumbIcon;
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
	// Cursors
	//----------------------------------------------------------------------------------------------
	
	static var _handUp:BitmapData;
	
	public static function getHandUp()
	{
		if (_handUp == null)
		{
			_handUp = newHand(false);
		}
		return _handUp;
	}
	
	static var _handDown:BitmapData;
	
	public static function getHandDown()
	{
		if (_handDown == null)
		{
			_handDown = newHand(true);
		}
		return _handDown;
	}
	
	static var _forbidden:BitmapData;
	
	public static function getForbidden()
	{
		if (_forbidden == null)
		{
			_forbidden = newForbidden();
		}
		return _forbidden;
	}
	
	static var _wait:BitmapData;
	
	public static function getWait()
	{
		if (_wait == null)
		{
			_wait = newWait();
		}
		return _wait;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Bitmap data customized generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newArrow(horizontal:Bool, left:Bool, color:UInt)
	{
		qualityOn();
		
		var g = _shape.graphics;
		g.clear();
		
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.moveTo(3, 1);
		g.lineTo(8, 7);
		g.lineTo(3, 13);
		g.lineTo(1, 11);
		g.lineTo(4, 7);
		g.lineTo(1, 3);
		g.endFill();
		
		var innerStrength = 1.7;
		
		var width = horizontal ? 13 : 14;
		var height = horizontal ? 14 : 13;
		var bitmapData = new BitmapData(width, height, true, 0x00000000);
		if (horizontal && !left)
		{
			bitmapData.draw(_shape);
		}
		else if (horizontal && left)
		{
			bitmapData.draw(_shape, new Matrix(-1, 0, 0, 1, width, 0));
		}
		else if (!horizontal && !left)
		{
			bitmapData.draw(_shape, new Matrix(0, 1, -1, 0, width, 0));
		}
		else
		{
			bitmapData.draw(_shape, new Matrix(0, -1, 1, 0, 0, height));
		}
		
		qualityOff();
		return bitmapData;
	}
	
	static function newSimpleBg(fillColor:UInt, borderColor:UInt)
	{
		qualityOn();
		
		var g = _shape.graphics;
		g.clear();

		g.beginFill(CMath.colorPart(borderColor), CMath.alphaPart(borderColor));
		g.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 6);
		g.drawRoundRect(1, 1, DEFAULT_WIDTH - 2, DEFAULT_HEIGHT - 2, 4);
		g.endFill();
		g.beginFill(CMath.colorPart(fillColor), CMath.alphaPart(fillColor));
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4);
		g.endFill();

		var bitmapData = new BitmapData(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, 0x0);
		bitmapData.draw(_shape);
		
		qualityOff();
		return bitmapData;
	}
	
	static function newGradientBg(colors:Array<UInt>, ratios:Array<Int>, shadow:Bool)
	{
		qualityOn();
		
		var g = _shape.graphics;
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
		getColorsAndAlphas(colors, finalColors, alphas);
		
		g.beginGradientFill(GradientType.LINEAR, finalColors, alphas, ratios, matrix);
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 8);
		g.endFill();
		
		g.beginFill(
			CMath.colorPart(buttonInnerBorderColor), CMath.alphaPart(buttonInnerBorderColor));
		g.drawRoundRect(2, 2, DEFAULT_WIDTH - 4, DEFAULT_HEIGHT - 4, 4);
		g.drawRoundRect(3, 3, DEFAULT_WIDTH - 6, DEFAULT_HEIGHT - 6, 6);
		g.endFill();

		var bitmapData = new BitmapData(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, 0x00000000);
		bitmapData.draw(_shape);
			
		qualityOff();
		return bitmapData;
	}
	
	static function newEllipseBg(selected:Bool, down:Bool)
	{
		qualityOn();
		
		var matrix = new Matrix();
		matrix.createGradientBox(BOX_HEIGHT, BOX_HEIGHT, Math.PI / 2);

		var g = _shape.graphics;
		g.clear();
		
		var colors = [];
		var alphas = [];
		getColorsAndAlphas(roundBorderColors, colors, alphas);
		
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
		getColorsAndAlphas(colors, finalColors, alphas);
		
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
		bitmapData.draw(_shape);
		
		qualityOff();
		return bitmapData;
	}
	
	static function newRoundBg(selected:Bool, down:Bool)
	{
		qualityOn();
		
		var matrix = new Matrix();
		matrix.createGradientBox(BOX_HEIGHT, BOX_HEIGHT, Math.PI / 2);

		var g = _shape.graphics;
		g.clear();
		
		var indent = down ? 3 : 4;
		
		{
			var width = BOX_HEIGHT;
			var height = BOX_HEIGHT;
			
			var colors = [];
			var alphas = [];
			getColorsAndAlphas(roundBorderColors, colors, alphas);
			
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
			getColorsAndAlphas(down ? roundColorsDown : roundColorsUp, colors, alphas);
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
		bitmapData.draw(_shape);
		
		qualityOff();
		return bitmapData;
	}
	
	static function newHand(down:Bool)
	{
		qualityOn();
		
		var g = _shape.graphics;
		g.clear();
		if (down)
		{
			drawHandDown(g, true);
			drawHandDown(g, false);
		}
		else
		{
			drawHandUp(g, true);
			drawHandUp(g, false);
		}
		
		var bitmapData = new BitmapData(20, 24, true, 0x00000000);
		bitmapData.draw(_shape);
		
		qualityOff();
		return bitmapData;
	}
	
	static function newForbidden()
	{
		qualityOn();
		
		var borderColor = 0x000000;
		var fillColor = 0x808080;
		var r = 8;
		var x0 = r + 2;
		var y0 = r + 2;
		
		var g = _shape.graphics;
		g.clear();
		
		g.lineStyle(4, borderColor);
		g.drawCircle(x0, y0, r);
		
		var sin = Math.sin(Math.PI * .25);
		var cos = Math.cos(Math.PI * .25);
		
		g.moveTo(x0 + sin * r, y0 + cos * r);
		g.lineTo(x0 - sin * r, y0 - cos * r);
		
		g.lineStyle(2, fillColor);
		g.drawCircle(x0, y0, r);
		
		g.moveTo(x0 + sin * r, y0 + cos * r);
		g.lineTo(x0 - sin * r, y0 - cos * r);
		
		var bitmapData = new BitmapData(x0 * 2 + 4, y0 * 2 + 4, true, 0x00000000);
		bitmapData.draw(_shape);
		bitmapData.applyFilter(
			bitmapData, bitmapData.rect, new Point(),
			new DropShadowFilter(2, 45, 0x000000, .5, 2, 2)
		);
		
		qualityOff();
		return bitmapData;
	}
	
	static function newWait()
	{
		qualityOn();
		
		var borderColor = 0x000000;
		var fillColor = 0x808080;
		var color = 0xffffff;
		var r = 10;
		var x0 = r + 2;
		var y0 = r + 2;
		
		var g = _shape.graphics;
		g.clear();
		
		g.beginFill(color);
		g.drawCircle(x0, y0, r);
		g.endFill();
		
		g.beginFill(fillColor);
		g.drawCircle(x0, y0, r + 1);
		g.drawCircle(x0, y0, r);
		g.endFill();
		
		g.beginFill(borderColor);
		g.drawCircle(x0, y0, r - 1);
		g.drawCircle(x0, y0, r - 3);
		g.endFill();
		
		g.lineStyle(1, borderColor);
		
		g.moveTo(x0 - r + 1, y0);
		g.lineTo(x0 - r + 5, y0);
		g.moveTo(x0 + r - 1, y0);
		g.lineTo(x0 + r - 5, y0);
		g.moveTo(x0, y0 + r - 1);
		g.lineTo(x0, y0 + r - 5);
		g.moveTo(x0, y0 - r + 1);
		g.lineTo(x0, y0 - r + 5);
		
		g.moveTo(x0, y0);
		g.lineTo(x0 + 3, y0 - 5);
		g.moveTo(x0, y0);
		g.lineTo(x0 + 4, y0 + 3);
		
		var bitmapData = new BitmapData(x0 * 2 + 4, y0 * 2 + 4, true, 0x00000000);
		bitmapData.draw(_shape);
		bitmapData.applyFilter(
			bitmapData, bitmapData.rect, new Point(),
			new DropShadowFilter(2, 45, 0x000000, .5, 2, 2)
		);
		
		qualityOff();
		return bitmapData;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	static function drawHandBegin(g:Graphics, drawBorder:Bool)
	{
		if (drawBorder)
		{
			g.lineStyle(2, 0x000000);
		}
		else
		{
			g.lineStyle();
			g.beginFill(0xffffff);
		}
	}
	
	static function drawHandEnd(g:Graphics, drawBorder:Bool)
	{
		if (!drawBorder)
		{
			g.endFill();
		}
	}
	
	static function drawHandUp(g:Graphics, drawBorder:Bool)
	{
		var x0 = 11;
		var y0 = 12;
		
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0, 11, 10, 6);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0 - 9, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 3, y0 - 10, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0, y0 - 10, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 + 3, y0 - 8, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		
		g.moveTo(x0 - 4, y0 + 10);
		drawHandBegin(g, drawBorder);
		g.lineTo(x0 - 10, y0 + 5);
		g.lineTo(x0 - 10, y0 - 1);
		g.lineTo(x0 - 8, y0);
		g.lineTo(x0 - 8, y0 + 2);
		g.lineTo(x0 - 7, y0 + 3);
		g.moveTo(x0 - 4, y0 + 3);
		drawHandEnd(g, drawBorder);
	}
	
	static function drawHandDown(g:Graphics, drawBorder:Bool)
	{
		var x0 = 11;
		var y0 = 12;
		
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0, 11, 10, 6);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0 - 4, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 3, y0 - 5, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0, y0 - 5, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 + 3, y0 - 4, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		
		g.moveTo(x0 - 4, y0 + 10);
		drawHandBegin(g, drawBorder);
		g.lineTo(x0 - 10, y0 + 4);
		g.lineTo(x0 - 8, y0);
		g.lineTo(x0 - 8, y0);
		g.lineTo(x0 - 7, y0 + 2);
		g.lineTo(x0 - 7, y0 + 3);
		g.moveTo(x0 - 4, y0 + 3);
		drawHandEnd(g, drawBorder);
	}
	
	inline static function getColorsAndAlphas(
		source:Array<UInt>, outColors:Array<UInt>, outAlphas:Array<Float>)
	{
		for (i in 0 ... source.length)
		{
			var color = source[i];
			outColors[i] = CMath.colorPart(color);
			outAlphas[i] = CMath.alphaPart(color);
		}
	}
	
	static var _shape = new Shape();
	
	static var _oldQuality:StageQuality;
	
	static function qualityOn()
	{
		var stage = Lib.current.stage;
		_oldQuality = stage.quality;
		if (_oldQuality != StageQuality.BEST && _oldQuality != StageQuality.HIGH)
		{
			stage.quality = StageQuality.HIGH;
		}
	}
	
	static function qualityOff()
	{
		var stage = Lib.current.stage;
		if (stage.quality != _oldQuality)
		{
			stage.quality = _oldQuality;
		}
	}
}