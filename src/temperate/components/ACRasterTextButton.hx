package temperate.components;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import temperate.components.ACButton;
import temperate.components.CButtonState;
import temperate.components.parametrization.CRasterParams;
import temperate.text.CDefaultFormatFactory;

class ACRasterTextButton extends ACButton
{
	function new() 
	{
		super();
	}
	
	var _size_tfValid:Bool;
	
	var _size_upValid:Bool;
	
	override function init()
	{
		_params = [];
		_measuringTf = new TextField();
		_measuringTf.autoSize = TextFieldAutoSize.LEFT;
		_tf = new TextField();
		_tf.selectable = false;
		_tf.autoSize = TextFieldAutoSize.LEFT;
		addChild(_tf);
	}
	
	override function doUpdateState()
	{
		_view_valid = false;
		postponeView();
	}
	
	override function updateText()
	{
		_tf.text = getCorrectLabel(_text);
		
		_size_tfValid = false;
		_size_valid = false;
		postponeSize();
	}
	
	var _params:Array<CRasterParams>;
		
	public function getState(state:CButtonState):CRasterParams
	{
		var params = _params[state.index];
		if (params == null)
		{
			params = new CRasterParams();
			_params[state.index] = params;
		}
		if (state == CButtonState.UP)
		{
			_size_upValid = false;
			_size_tfValid = false;
			_size_valid = false;
			postponeSize();
		}
		if (state == _state)
		{
			_view_valid = false;
			postponeView();
		}
		return params;
	}
	
	var _measuringTf:TextField;
	
	var _tf:TextField;
	
	var _tfWidth:Int;
	
	var _tfHeight:Int;
	
	inline function size_tfValidate()
	{
		if (!_size_tfValid)
		{
			_size_tfValid = true;
			
			_measuringTf.text = getCorrectLabel(_text);
			
			var upParams = _params[CButtonState.UP.index];
			var format = null;
			if (upParams != null)
			{
				format = upParams.format;
			}
			if (format == null)
			{
				format = CDefaultFormatFactory.getDefaultFormat();
			}
			format.applyTo(_measuringTf, true);
			
			_tfWidth = Std.int(_measuringTf.width);
			_tfHeight = Std.int(_measuringTf.height);
		}
	}
	
	inline function getCurrentFormat(
		params:CRasterParams, upParams:CRasterParams)
	{
		var format = null;
		if (params != null)
		{
			format = params.format;
		}
		if (format == null && upParams != null)
		{
			format = upParams.format;
		}
		if (format == null)
		{
			format = CDefaultFormatFactory.getDefaultFormat();
		}
		return format;
	}
}