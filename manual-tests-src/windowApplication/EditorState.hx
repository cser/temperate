package windowApplication;
import temperate.extra.CSignal;
import windowApplication.states.ADrawState;

class EditorState
{
	public function new() 
	{
		colorChanged = new CSignal();
		toolChanged = new CSignal();
	}
	
	public var colorChanged(default, null):CSignal < Void->Void > ;
	
	public var color(get_color, set_color):Int;
	var _color:Int;
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
	
	public var toolChanged(default, null):CSignal < Void->Void > ;
	
	public var tool(get_tool, set_tool):ADrawState;
	var _tool:ADrawState;
	function get_tool()
	{
		return _tool;
	}
	function set_tool(value)
	{
		if (_tool != value)
		{
			if (_tool != null)
			{
				_tool.setImage(null, null);
			}
			_tool = value;
			toolChanged.dispatch();
		}
		return _tool;
	}
}