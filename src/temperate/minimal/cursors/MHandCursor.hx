package temperate.minimal.cursors;
import flash.ui.MouseCursor;
import temperate.cursors.CRasterPressCursor;
import temperate.minimal.graphics.MCursorBdFactory;

class MHandCursor extends CRasterPressCursor
{
	public function new(
		updateOnMove:Bool = false, hideSystem:Bool = true, system:MouseCursor = null) 
	{
		super();
		
		setView(
			MCursorBdFactory.getHandUp(), MCursorBdFactory.getHandDown(), updateOnMove,
			hideSystem ? 0 : 14,
			hideSystem ? 0 : 16
		);
		
		setHideSystem(hideSystem);
		setSystem(system);
	}	
}