package temperate.containers;
import temperate.layouts.parametrization.CExcessSpaceMode;
import temperate.layouts.CVLayout;

class CVBox extends ACLineBox
{
	var _vLayaut:CVLayout;
	
	public function new() 
	{
		_vLayaut = new CVLayout();
		super(_vLayaut);
	}
	
	public var excessSpaceMode(get_excessSpaceMode, set_excessSpaceMode):CExcessSpaceMode;
	function get_excessSpaceMode()
	{
		return _vLayaut.excessSpaceMode;
	}
	function set_excessSpaceMode(value)
	{
		_vLayaut.excessSpaceMode = value;
		_size_valid = false;
		postponeSize();
		return value;
	}
}