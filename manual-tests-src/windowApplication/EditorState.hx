package windowApplication;
import temperate.extra.CSignal;

class EditorState
{
	public function new() 
	{
		colorChanged = new CSignal();
	}
	
	public var colorChanged(default, null):CSignal < Void->Void > ;
	
	public var color(get_color, set_color):UInt;
	var _color:UInt;
	function get_color()
	{
		return _color;
	}
	function set_color(value)
	{
		if (_color != value)
		{
			_color = value;
			colorChanged.dispatch();
		}
		return _color;
	}
}