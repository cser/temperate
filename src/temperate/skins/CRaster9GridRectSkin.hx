package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import temperate.components.parametrization.CRasterParameters;
import temperate.raster.CScale9GridDrawer;

class CRaster9GridRectSkin implements ICRectSkin
{	
	public function new() 
	{
		state = CSkinState.NORMAL;
		_parameters = [];
		
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
			
			var parameters = _parameters[state.index];
			var defaultParameters = _parameters[CSkinState.NORMAL.index];
			if (parameters == null)
			{
				parameters = defaultParameters;
			}
			if (parameters != null)
			{
				_shape.filters = parameters.filters;
				_shape.alpha = Math.isNaN(parameters.alpha) ? 1 : parameters.alpha;
				_drawer.setBitmapData(parameters.bitmapData);
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
	
	var _parameters:Array<CRasterParameters>;
	
	public function getState(state:CSkinState):CRasterParameters
	{
		var parameters = _parameters[state.index];
		if (parameters == null)
		{
			parameters = new CRasterParameters();
			_parameters[state.index] = parameters;
		}
		return parameters;
	}
}