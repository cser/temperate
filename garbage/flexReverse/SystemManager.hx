package flexReverse;
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.EventDispatcher;

class SystemManager extends EventDispatcher
{
	public function new(document:DisplayObject, stage:Stage) 
	{
		super();
		_document = document;
		_stage = stage;
	}
	
	public var document(get_document, null):DisplayObject;
	var _document:DisplayObject;
	function get_document()
	{
		return _document;
	}
	
	public var stage(get_stage, null):Stage;
	var _stage:Stage;
	function get_stage()
	{
		return _stage;
	}
}