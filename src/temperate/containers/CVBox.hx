package temperate.containers;
import temperate.layouts.ExcessSpaceMode;
import temperate.layouts.VLayout;

class CVBox extends ACLineBox
{
	var _vLayaut:VLayout;
	
	public function new() 
	{
		_vLayaut = new VLayout();
		super(_vLayaut);
	}
	
	public var excessSpaceMode(get_excessSpaceMode, set_excessSpaceMode):ExcessSpaceMode;
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