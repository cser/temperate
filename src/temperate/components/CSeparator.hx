package temperate.components;
import temperate.core.CSprite;

class CSeparator extends CSprite 
{
	public function new(horizontal:Bool)
	{
		super();
		
		_horizontal = horizontal;
		
		_lineWidth = getLineWidth();
		if (_horizontal)
		{
			_width = 10;
			_height = _lineWidth;
		}
		else
		{
			_width = _lineWidth;
			_height = 10;
		}
		_view_valid = false;
		postponeView();
	}
	
	var _lineWidth:Int;
	
	function getLineWidth():Int
	{
		return 1;
	}
	
	var _horizontal:Bool;
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			if (_horizontal)
			{
				_height = 2;
			}
			else
			{
				_width = 2;
			}
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			redraw();
		}
	}
	
	function redraw()
	{
		var g = graphics;
		g.clear();
		g.lineStyle(0, 0x000000);
		if (_horizontal)
		{
			g.moveTo(0, 0);
			g.lineTo(_width, 0);
		}
		else
		{
			g.moveTo(0, 0);
			g.lineTo(0, _height);
		}
	}
}