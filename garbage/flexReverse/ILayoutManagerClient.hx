package flexReverse;

import flash.events.IEventDispatcher;
import flash.display.DisplayObject;

interface ILayoutManagerClient implements IEventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  initialized
    //----------------------------------
	
	var displayObject(default, null):DisplayObject;

    /**
     *  A flag that determines if an object has been through all three phases
     *  of layout validation (provided that any were required)
     *  This flag should only be modified by the LayoutManager.
     */
	var initialized(get_initialized, set_initialized):Bool;

    //----------------------------------
    //  nestLevel
    //----------------------------------

    /**
     *  The top-level SystemManager has a nestLevel of 1.
     *  Its immediate children (the top-level Application and any pop-up
     *  windows) have a <code>nestLevel</code> of 2.
     *  Their children have a <code>nestLevel</code> of 3, and so on.  
     *
     *  The <code>nestLevel</code> is used to sort ILayoutManagerClients
     *  during the measurement and layout phases.
     *  During the commit phase, the LayoutManager commits properties on clients
     *  in order of increasing <code>nestLevel</code>, so that an object's
     *  children have already had their properties committed before Flex 
     *  commits properties on the object itself.
     *  During the measurement phase, the LayoutManager measures clients
     *  in order of decreasing <code>nestLevel</code>, so that an object's
     *  children have already been measured before Flex measures
     *  the object itself.
     *  During the layout phase, the LayoutManager lays out clients
     *  in order of increasing <code>nestLevel</code>, so that an object
     *  has a chance to set the sizes of its children before the child
     *  objects are asked to position and size their children.
     */
	var nestLevel(get_nestLevel, set_nestLevel):Int;

    //----------------------------------
    //  processedDescriptors
    //----------------------------------
	
    /**
     *  @copy mx.core.UIComponent#processedDescriptors
     */
    var processedDescriptors(get_processedDescriptors, set_processedDescriptors):Bool;

    //----------------------------------
    //  updateCompletePendingFlag
    //----------------------------------

    /**
     *  A flag that determines if an object is waiting to have its
     *  <code>updateComplete</code> event dispatched.
     *  This flag should only be modified by the LayoutManager.
     */
	var updateCompletePendingFlag(
		get_updateCompletePendingFlag, set_updateCompletePendingFlag):Bool;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Validates the properties of a component.
     *  If the <code>LayoutManager.invalidateProperties()</code> method is called with
     *  this ILayoutManagerClient, then the <code>validateProperties()</code> method
     *  is called when it's time to commit property values.
     */
    function validateProperties():Void;
    
    /**
     *  Validates the measured size of the component
     *  If the <code>LayoutManager.invalidateSize()</code> method is called with
     *  this ILayoutManagerClient, then the <code>validateSize()</code> method
     *  is called when it's time to do measurements.
     *
     *  @param recursive If <code>true</code>, call this method
     *  on the objects children.
     */
    function validateSize(recursive:Bool = false):Void;
    
    /**
     *  Validates the position and size of children and draws other
     *  visuals.
     *  If the <code>LayoutManager.invalidateDisplayList()</code> method is called with
     *  this ILayoutManagerClient, then the <code>validateDisplayList()</code> method
     *  is called when it's time to update the display list.
     */
    function validateDisplayList():Void;
}
