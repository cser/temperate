package windowApplication.states;
import temperate.core.CSprite;

class ADrawState 
{
	function new() 
	{
	}
	
	var _image:CSprite;
	
	public function setImage(image:CSprite)
	{
		if (_image != image)
		{
			if (_image != null)
			{
				unsubscribe();
			}
			_image = image;
			if (_image != null)
			{
				subscribe();
			}
		}
	}
	
	function unsubscribe()
	{
	}
	
	function subscribe()
	{
	}
}