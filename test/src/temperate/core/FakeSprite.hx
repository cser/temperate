package temperate.core;

class FakeSprite extends ACValidatable
{
	public function new(name:String, validator:CValidator) 
	{
		log = [];
		_name = name;
		super(validator);
	}
	
	var _name:String;
	
	override public function toString():String
	{
		return _name;
	}
	
	public var log:Array<String>;
	
	override function doValidateSize():Void
	{
		_size_valid = true;
		log.push("doValidateSize");
	}
	
	override function doValidateView():Void
	{
		_view_valid = true;
		log.push("doValidateView");
	}
}