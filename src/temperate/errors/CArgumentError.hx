package temperate.errors;
import flash.errors.Error;

/**
 * Use this error insterd flash.errors.ArgumentError becouse haxe 2.07 has bug with this error
 */
class CArgumentError extends Error
{
	public function new(?message:Dynamic, id:Dynamic = 0)
	{
		super(message, id);
	}
}