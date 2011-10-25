package temperate.minimal;
import temperate.text.CLabel;

class MLabel extends CLabel
{
	public function new() 
	{
		super();
		
		format = MFormatFactory.LABEL;
	}	
}