package temperate.components;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import temperate.components.ACButton;
import temperate.components.CButtonState;
import temperate.components.parametrization.CRasterParameters;
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
		_parameters = [];
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
	
	var _parameters:Array<CRasterParameters>;
		
	public function getState(state:CButtonState):CRasterParameters
	{
		var parameters = _parameters[state.index];
		if (parameters == null)
		{
			parameters = new CRasterParameters();
			_parameters[state.index] = parameters;
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
		return parameters;
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
			
			var upParameters = _parameters[CButtonState.UP.index];
			var format = null;
			if (upParameters != null)
			{
				format = upParameters.format;
			}
			if (format == null)
			{
				format = CDefaultFormatFactory.getDefaultFormat();
			}
			format.applyTo(_measuringTf);
			
			_tfWidth = Std.int(_measuringTf.width);
			_tfHeight = Std.int(_measuringTf.height);
		}
	}
	
	inline function getCurrentFormat(
		parameters:CRasterParameters, upParameters:CRasterParameters)
	{
		var format = null;
		if (parameters != null)
		{
			format = parameters.format;
		}
		if (format == null && upParameters != null)
		{
			format = upParameters.format;
		}
		if (format == null)
		{
			format = CDefaultFormatFactory.getDefaultFormat();
		}
		return format;
	}
}