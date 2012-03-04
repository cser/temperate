package temperate.minimal.cursors;
import temperate.cursors.CMouseCursor;
import temperate.cursors.CRasterPressCursor;
import temperate.minimal.graphics.MCursorBdFactory;

class MHandCursor extends CRasterPressCursor
{
	public function new(
		updateOnMove:Bool = false, hideSystem:Bool = true, mouseCursor:CMouseCursor = null) 
	{
		super();
		
		setView(
			MCursorBdFactory.getHandUp(), MCursorBdFactory.getHandDown(), updateOnMove,
			hideSystem ? -5 : 14,
			hideSystem ? -5 : 16
		);
		
		setHideSystem(hideSystem);
		setSystem(mouseCursor);
	}	
}