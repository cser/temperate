package temperate.skins;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import temperate.raster.ICDrawer;

class CRasterScrollDrawedSkin implements ICScrollSkin
{
	var _up:BitmapData;
	var _drawer:ICDrawer;
	var _crossSize:Int;
	
	public function new(up:BitmapData, drawer:ICDrawer, crossSize:Int)
	{
		_up = up;
		_drawer = drawer;
		_crossSize = crossSize;
		
		leftIndent = 0;
		rightIndent = 0;
		crossIndent = 0;
		
		_drawer.setBitmapData(_up);
	}
	
	var leftIndent:Int;
	var rightIndent:Int;
	var crossIndent:Int;
	
	public function setIndents(leftIndent:Int, rightIndent:Int, crossIndent:Int)
	{
		this.leftIndent = leftIndent;
		this.rightIndent = rightIndent;
		this.crossIndent = crossIndent;
		return this;
	}
	
	var _horizontal:Bool;
	
	public function link(
		horizontal:Bool, addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic,
		graphics:Graphics
	):Void
	{
		_horizontal = horizontal;
		_drawer.graphics = graphics;
	}
	
	public function unlink():Void
	{
		_drawer.clear();
	}
	
	var _scrollLeft:Int;
	var _scrollSize:Int;
	var _size:Int;
	
	public function setSize(scrollLeft:Int, scrollSize:Int, size:Int):Void
	{
		_scrollLeft = scrollLeft;
		_scrollSize = scrollSize;
		_size = size;
	}
	
	public function redrawUp()
	{
		if (_horizontal)
		{
			_drawer.setBounds(
				leftIndent, crossIndent, _size - leftIndent - rightIndent, _crossSize);
		}
		else
		{
			_drawer.setBounds(
				crossIndent, leftIndent, _crossSize, _size - leftIndent - rightIndent);
		}
		_drawer.redraw();
	}
	
	public function redrawDown(isLeft:Bool, thumbCenter:Int)
	{
		redrawUp();
	}
}