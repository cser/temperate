package temperate.minimal;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.text.CInputField;

class MInputField extends CInputField
{
	public function new() 
	{
		super(new MFieldRectSkin());
		
		format = MFormatFactory.LABEL;
		formatError = MFormatFactory.LABEL_ERROR;
		formatDisabled = MFormatFactory.LABEL_DISABLED;
		
		setTextIndents(2, 2, 2, 2);
	}	
}