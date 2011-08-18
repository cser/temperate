package temperate.errors;
import flash.errors.Error;

class MastOverrideError extends Error
{
	public function new() 
	{
		super("Mast override");
	}
}