package temperate.minimal.cursors;
import flash.display.Bitmap;
import temperate.cursors.CCursor;
import temperate.minimal.graphics.MCursorBdFactory;

class MResizeCursor extends CCursor
{
	public function new(updateOnMove:Bool = false, hideSystem:Bool = true, system:String = null) 
	{
		super();
		
		setView(
			new Bitmap(MCursorBdFactory.getResize()),
			updateOnMove,
			hideSystem ? -8 : 12,
			hideSystem ? -8 : 10
		);
		
		setHideSystem(hideSystem);
		setSystem(system);
	}
}