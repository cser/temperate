package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import temperate.components.parametrization.CRasterParams;
import temperate.raster.CScale9GridDrawer;

class CRaster9GridRectSkin implements ICRectSkin
{	
	public function new() 
	{
		state = CSkinState.NORMAL;
		_params = [];
		
		_shape = new Shape();
		_drawer = new CScale9GridDrawer(_shape.graphics);
	}
	
	var _shape:Shape;
	var _drawer:CScale9GridDrawer;
	var _removeChild:DisplayObject->Dynamic;
	
	public function link(
		addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic, graphics:Graphics
	):Void
	{
		_removeChild = removeChild;
		addChildAt0(_shape);
	}
	
	public function unlink():Void
	{
		_removeChild(_shape);
	}
	
	public var minWidth(default, null):Int;
	
	public var minHeight(default, null):Int;
	
	public var state:CSkinState;
	
	var _oldState:CSkinState;
	
	public function setBounds(x:Int, y:Int, width:Int, height:Int):Void
	{
		_drawer.setBounds(x, y, width, height);
	}
	
	public function redraw():Void
	{		
		if (_oldState != state)
		{
			_oldState = state;
			
			var params = _params[state.index];
			var defaultParams = _params[CSkinState.NORMAL.index];
			if (params == null)
			{
				params = defaultParams;
			}
			if (params != null)
			{
				_shape.filters = params.filters;
				_shape.alpha = Math.isNaN(params.alpha) ? 1 : params.alpha;
				_drawer.setBitmapData(params.bitmapData);
			}
			else
			{
				_shape.filters = null;
				_drawer.setBitmapData(null);
				_shape.alpha = 1;
			}
		}
		_drawer.redraw();
	}
	
	public function getFixedWidth():Float
	{
		return Math.NaN;
	}
	
	public function getFixedHeight():Float
	{
		return Math.NaN;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	public function setMinSize(width:Int, height:Int)
	{
		minWidth = width;
		minHeight = height;
		return this;
	}
	
	public function setGrid9Insets(left:Int, right:Int, top:Int, bottom:Int)
	{
		_drawer.setInsets(left, right, top, bottom);
	}
	
	var _params:Array<CRasterParams>;
	
	public function getState(state:CSkinState):CRasterParams
	{
		var params = _params[state.index];
		if (params == null)
		{
			params = new CRasterParams();
			_params[state.index] = params;
		}
		return params;
	}
}