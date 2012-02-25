package windowApplication;
import flash.net.SharedObject;
import haxe.Serializer;
import haxe.Unserializer;

class Storage 
{
	public function new() 
	{
		_sharedObject = SharedObject.getLocal("temperate_test");
	}
	
	var _sharedObject:SharedObject;
	
	public var names(get_names, null):Array<String>;
	function get_names()
	{
		var names = [];
		for (name in Reflect.fields(_sharedObject.data))
		{
			names.push(name);
		}
		return names;
	}
	
	public function getImageData(name:String):ImageData
	{
		return Unserializer.run(Reflect.field(_sharedObject.data, name));
	}
	
	public function exists(name:String):Bool
	{
		return Reflect.hasField(_sharedObject.data, name);
	}
	
	public function save(name:String, imageData:ImageData):Void
	{
		Reflect.setField(_sharedObject.data, name, Serializer.run(imageData));
		_sharedObject.flush();
	}
	
	public function remove(name:String):Void
	{
		Reflect.deleteField(_sharedObject.data, name);
		_sharedObject.flush();
	}
}