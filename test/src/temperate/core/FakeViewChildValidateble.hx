package temperate.core;
import temperate.core.ACValidatable;
import temperate.core.CValidator;

class FakeViewChildValidateble extends ACValidatable
{
	public function new(name:String, validator:CValidator) 
	{
		_name = name;
		
		super(validator);
		
		_components = [];
	}
	
	var _name:String;
	var _components:Array<FakeViewChildValidateble>;
	
	override public function toString():String
	{
		return _name;
	}
	
	inline function postponeSize():Void
	{
		_validator.postponeSize(this);
	}
	
	inline function postponeView():Void
	{
		_validator.postponeView(this);
	}
	
	public function add(child:FakeViewChildValidateble):Void
	{
		super.addChild(child);
		_components.push(child);
		_view_valid = false;
		postponeView();
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			for (component in _components)
			{
				component.validate();
			}
		}
	}
	
	public function invalidate():Void
	{
		_view_valid = false;
		postponeSize();
	}
	
	public function validate():Void
	{
		__validateView();
	}
}