package temperate.minimal.cursors;
import flash.display.Bitmap;
import flash.ui.MouseCursor;
import temperate.cursors.CCursor;
import temperate.minimal.graphics.MCursorBdFactory;

class MWaitCursor extends CCursor
{
	public function new(
		updateOnMove:Bool = false, hideSystem:Bool = false, system:MouseCursor = null) 
	{
		super();
		
		setView(
			new Bitmap(MCursorBdFactory.getWait()),
			updateOnMove,
			hideSystem ? 0 : 14,
			hideSystem ? 0 : 16
		);
		
		setHideSystem(hideSystem);
		setSystem(system);
	}	
}