package temperate.core;
import flash.display.Sprite;

class ACValidatable extends Sprite
{
	public function new(validator:CValidator) 
	{
		super();
		_validator = validator;
	}
	
	var _validator:CValidator;
	
	public var __sp:ACValidatable;
	public var __sn:ACValidatable;
	public var __vp:ACValidatable;
	public var __vn:ACValidatable;
	
	public function __validateSize():Void
	{
		_validator.removeSize(this);
		doValidateSize();
	}
	
	public function __validateView():Void
	{
		_validator.removeSize(this);
		doValidateSize();
		_validator.removeView(this);
		doValidateView();
	}
	
	var _size_valid:Bool;
	var _view_valid:Bool;
	
	/**
	 * There validates all that accessible from properties
	 * It's meen, that all properties always accessed as valid
	 */
	function doValidateSize():Void
	{
		_size_valid = true;
	}
	
	/**
	 * There validates all that can't be accessible from prperties
	 * (it user see on screen only)
	 */
	function doValidateView():Void
	{
		_view_valid = true;
	}
}