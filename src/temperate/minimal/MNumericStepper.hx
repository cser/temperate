package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CNumericStepper;
import temperate.components.CRasterFixedButton;
import temperate.core.CMath;
import temperate.minimal.skins.MFieldRectSkin;

class MNumericStepper extends CNumericStepper
{	
	public function new() 
	{
		var up = new CRasterFixedButton();
		up.getState(CButtonState.UP).setBitmapData(MBitmapDataFactory.getUpArrowUp());
		up.getState(CButtonState.OVER).setBitmapData(MBitmapDataFactory.getUpArrowOver());
		up.getState(CButtonState.DOWN).setBitmapData(MBitmapDataFactory.getUpArrowOver())
			.setBgOffset(0, 0, -1, 0);
		up.getState(CButtonState.DISABLED).setBitmapData(MBitmapDataFactory.getUpArrowUp())
			.setAlpha(.4);
		
		var down = new CRasterFixedButton();
		down.getState(CButtonState.UP).setBitmapData(MBitmapDataFactory.getDownArrowUp());
		down.getState(CButtonState.OVER).setBitmapData(MBitmapDataFactory.getDownArrowOver());
		down.getState(CButtonState.DOWN).setBitmapData(MBitmapDataFactory.getDownArrowOver())
			.setBgOffset(0, 0, 1, 0);
		down.getState(CButtonState.DISABLED).setBitmapData(MBitmapDataFactory.getDownArrowUp())
			.setAlpha(.4);
		
		_buttonsWidth = Std.int(up.width + 2);
		
		super(up, down, new MFieldRectSkin());
		
		format = MFormatFactory.LABEL;
		formatError = MFormatFactory.LABEL_ERROR;
		formatDisabled = MFormatFactory.LABEL_DISABLED;
	}
	
	var _buttonsWidth:Int;
	
	static var TEXT_INDENT = 2;
	
	override function updateSize()
	{
		var minWidth = _tfMinWidth + _buttonsWidth + TEXT_INDENT * 2;
		_height = _tfMinHeight + TEXT_INDENT * 2;
		if (_isCompactWidth)
		{
			_width = minWidth;
		}
		else
		{
			_width = CMath.max(minWidth, _settedWidth);
		}
	}
	
	override function updateArrange()
	{
		var centerY:Int = Std.int(_height * .5);
		
		_tf.height = _tfMinHeight + 2;
		_tf.width = _width - _buttonsWidth - TEXT_INDENT;
		_tf.x = TEXT_INDENT;
		_tf.y = centerY - (_tfMinHeight >> 1);
		
		_up.x = _width - _buttonsWidth;
		_up.y = centerY - _up.height;
		
		_down.x = _width - _buttonsWidth;
		_down.y = centerY;
		
		_bg.setBounds(0, 0, Std.int(_width), Std.int(_height));
	}
}