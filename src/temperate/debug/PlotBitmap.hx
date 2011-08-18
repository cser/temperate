package temperate.debug;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

class PlotBitmap extends Bitmap
{
	static var BG_COLOR = 0x00000000;
	
	var _bd:BitmapData;
	
	var _width:Int;
	
	var _height:Int;
	
	var _maxValue:Float;
	
	public function new(width:Int, height:Int, maxValue:Float)
	{
		_bd = new BitmapData(width, height, true, BG_COLOR);
		_width = width;
		_height = height;
		_maxValue = maxValue;
		_endRect = new Rectangle(_width - 1, 0, 1, _height);
		super(_bd);
	}
	
	var _matrix:Matrix;
	
	var _bdTemp:BitmapData;
	
	var _tempRect:Rectangle;
	
	public function setMax(value:Float)
	{
		var ratio = _maxValue / value;
		_maxValue = value;
		
		if (_matrix == null)
		{
			_matrix = new Matrix();
		}
		_matrix.d = ratio;
		_matrix.ty = _height * (1 - ratio);
		
		if (_bdTemp == null)
		{
			_bdTemp = new BitmapData(_width, _height, true, BG_COLOR);
		}
		else
		{
			if (_tempRect == null)
			{
				_tempRect = new Rectangle(0, 0, _width, _height);
			}
			_bdTemp.fillRect(_tempRect, BG_COLOR);
		}
		_bdTemp.draw(_bd, _matrix, null, null, null, true);
		
		var temp = _bd;
		_bd = _bdTemp;
		_bdTemp = temp;
		bitmapData = _bd;
	}
	
	var _endRect:Rectangle;
	
	public function plot(value:Float, color:UInt)
	{
		_bd.setPixel32(_width - 1, Std.int(_height * (1 - value / _maxValue)), color);
	}
	
	public function scroll()
	{
		_bd.scroll(-1, 0);
		_bd.fillRect(_endRect, BG_COLOR);
	}
}