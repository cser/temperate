package flexReverse;
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.errors.SecurityError;
import flexReverse.events.FlexEvent;
import temperate.core.CMath;

class LayoutManager extends EventDispatcher
{	
	public function new(systemManager:SystemManager)
	{
		super();
		
		_updateCompleteQueue = new PriorityQueue();
		_invalidatePropertiesQueue = new PriorityQueue();
		_invalidatePropertiesFlag = false;
		_invalidateClientPropertiesFlag = false;
		_invalidateSizeQueue = new PriorityQueue();
		_invalidateSizeFlag = false;
		_invalidateDisplayListFlag = false;
		_invalidateClientSizeFlag = false;
		_invalidateDisplayListQueue = new PriorityQueue();
		_waitedAFrame = false;
		_listenersAttached = false;
		_targetLevel = CMath.INT_MAX_VALUE;
		_usePhasedInstantiation = false;
        this._systemManager = systemManager;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 *  A queue of Dynamics that need to dispatch updateComplete events
	 *  when invalidation processing is complete
	 */
	private var _updateCompleteQueue:PriorityQueue;

	/**
	 *  @private
	 *  A queue of Dynamics to be processed during the first phase
	 *  of invalidation processing, when an ILayoutManagerClient  has
	 *  its validateProperties() method called (which in a UIComponent
	 *  calls commitProperties()).
	 *  Dynamics are added to this queue by invalidateProperties()
	 *  and removed by validateProperties().
	 */
	private var _invalidatePropertiesQueue:PriorityQueue;

	/**
	 *  @private
	 *  A flag indicating whether there are Dynamics
	 *  in the _invalidatePropertiesQueue.
	 *  It is set true by invalidateProperties()
	 *  and set false by validateProperties().
	 */
	private var _invalidatePropertiesFlag:Bool;

	// flag when in validateClient to check the properties queue again
	private var _invalidateClientPropertiesFlag:Bool;

	/**
	 *  @private
	 *  A queue of Dynamics to be processed during the second phase
	 *  of invalidation processing, when an ILayoutManagerClient  has
	 *  its validateSize() method called (which in a UIComponent
	 *  calls measure()).
	 *  Dynamics are added to this queue by invalidateSize().
	 *  and removed by validateSize().
	 */
	private var _invalidateSizeQueue:PriorityQueue;

	/**
	 *  @private
	 *  A flag indicating whether there are Dynamics
	 *  in the _invalidateSizeQueue.
	 *  It is set true by invalidateSize()
	 *  and set false by validateSize().
	 */
	private var _invalidateSizeFlag:Bool;

	// flag when in validateClient to check the size queue again
	private var _invalidateClientSizeFlag:Bool;

	/**
	 *  @private
	 *  A queue of Dynamics to be processed during the third phase
	 *  of invalidation processing, when an ILayoutManagerClient  has
	 *  its validateDisplayList() method called (which in a
	 *  UIComponent calls updateDisplayList()).
	 *  Dynamics are added to this queue by invalidateDisplayList()
	 *  and removed by validateDisplayList().
	 */
	private var _invalidateDisplayListQueue:PriorityQueue;

	/**
	 *  @private
	 *  A flag indicating whether there are Dynamics
	 *  in the invalidateDisplayListQueue.
	 *  It is set true by invalidateDisplayList()
	 *  and set false by validateDisplayList().
	 */
	private var _invalidateDisplayListFlag:Bool;

	/**
	 *  @private
	 */
	private var _waitedAFrame:Bool;
	private var _listenersAttached:Bool;

	/**
	 *  @private
	 */
	private var _originalFrameRate:Float;

	/**
	 *  @private
	 *  used in validateClient to quickly estimate whether we have to
	 *  search the queues again
	 */
	private var _targetLevel:Int;

    /**
     *  @private
     *  the top level systemmanager
     */
    private var _systemManager:SystemManager;

	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  usePhasedInstantiation
	//----------------------------------

	/**
	 *  @private
	 *  Storage for the usePhasedInstantiation property.
	 */
	private var _usePhasedInstantiation:Bool;

	/**
	 *  A flag that indicates whether the LayoutManager allows screen updates
	 *  between phases.
	 *  If <code>true</code>, measurement and layout are done in phases, one phase
	 *  per screen update.
	 *  All components have their <code>validateProperties()</code> 
	 *  and <code>commitProperties()</code> methods 
	 *  called until all their properties are validated.  
	 *  The screen will then be updated.  
	 * 
	 *  <p>Then all components will have their <code>validateSize()</code> 
	 *  and <code>measure()</code>
	 *  methods called until all components have been measured, then the screen
	 *  will be updated again.  </p>
	 *
	 *  <p>Finally, all components will have their
	 *  <code>validateDisplayList()</code> and 
	 *  <code>updateDisplayList()</code> methods called until all components
	 *  have been validated, and the screen will be updated again.  
	 *  If in the validation of one phase, an earlier phase gets invalidated, 
	 *  the LayoutManager starts over.  
	 *  This is more efficient when large numbers of components
	 *  are being created an initialized.  The framework is responsible for setting
	 *  this property.</p>
	 *
	 *  <p>If <code>false</code>, all three phases are completed before the screen is updated.</p>
	 */
	public var usePhasedInstantiation(get_usePhasedInstantiation, set_usePhasedInstantiation):Bool;
	function get_usePhasedInstantiation()
	{
		return _usePhasedInstantiation;
	}
	function set_usePhasedInstantiation(value:Bool)
	{
		if (_usePhasedInstantiation != value)
		{
			_usePhasedInstantiation = value;

			// While we're doing phased instantiation, temporarily increase
			// the frame rate.  That will cause the enterFrame and render
			// events to fire more promptly, which improves performance.
			try {
                // can't use FlexGlobals here.  It may not be setup yet
                var stage:Stage = _systemManager.stage;
				if (stage != null)
				{
					if (value)
					{
						_originalFrameRate = stage.frameRate;
						stage.frameRate = 1000;
					}
					else
					{
						stage.frameRate = _originalFrameRate;
					}
				}
			}
			catch (e:SecurityError)
			{
			}
		}
		return _usePhasedInstantiation;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods: Invalidation
	//
	//--------------------------------------------------------------------------

	/**
	 *  Adds an Dynamic to the list of components that want their 
	 *  <code>validateProperties()</code> method called.
	 *  A component should call this method when a property changes.  
	 *  Typically, a property setter method
	 *  stores a the new value in a temporary variable and calls 
	 *  the <code>invalidateProperties()</code> method 
	 *  so that its <code>validateProperties()</code> 
	 *  and <code>commitProperties()</code> methods are called
	 *  later, when the new value will actually be applied to the component and/or
	 *  its children.  The advantage of this strategy is that often, more than one
	 *  property is changed at a time and the properties may interact with each
	 *  other, or repeat some code as they are applied, or need to be applied in
	 *  a specific order.  This strategy allows the most efficient method of
	 *  applying new property values.
	 *
	 *  @param obj The Dynamic whose property changed.
	 */
	public function invalidateProperties(obj:ILayoutManagerClient):Void
	{
        if (!_invalidatePropertiesFlag && _systemManager != null)
		{
			_invalidatePropertiesFlag = true;

			if (!_listenersAttached)
                attachListeners(_systemManager);
		}

		if (_targetLevel <= obj.nestLevel)
			_invalidateClientPropertiesFlag = true;

		_invalidatePropertiesQueue.addObject(obj, obj.nestLevel);
	}

	/**
	 *  Adds an Dynamic to the list of components that want their 
	 *  <code>validateSize()</code> method called.
	 *  Called when an Dynamic's size changes.
	 *
	 *  <p>An Dynamic's size can change for two reasons:</p>
	 *
	 *  <ol>
	 *    <li>The content of the Dynamic changes. For example, the size of a
	 *    button changes when its <code>label</code> is changed.</li>
	 *    <li>A script explicitly changes one of the following properties:
	 *    <code>minWidth</code>, <code>minHeight</code>,
	 *    <code>explicitWidth</code>, <code>explicitHeight</code>,
	 *    <code>maxWidth</code>, or <code>maxHeight</code>.</li>
	 *  </ol>
	 *
	 *  <p>When the first condition occurs, it's necessary to recalculate
	 *  the measurements for the Dynamic.
	 *  When the second occurs, it's not necessary to recalculate the
	 *  measurements because the new size of the Dynamic is known.
	 *  However, it's necessary to remeasure and relayout the Dynamic's
	 *  parent.</p>
	 *
	 *  @param obj The Dynamic whose size changed.
	 */
	public function invalidateSize(obj:ILayoutManagerClient):Void
	{
        if (!_invalidateSizeFlag && _systemManager != null)
		{
			_invalidateSizeFlag = true;

			if (!_listenersAttached)
			{
                attachListeners(_systemManager);
			}
		}

		if (_targetLevel <= obj.nestLevel)
			_invalidateClientSizeFlag = true;

		_invalidateSizeQueue.addObject(obj, obj.nestLevel);
	}

	/**
	 *  Called when a component changes in some way that its layout and/or visuals
	 *  need to be changed.
	 *  In that case, it is necessary to run the component's layout algorithm,
	 *  even if the component's size hasn't changed.  For example, when a new child component
	 *  is added, or a style property changes or the component has been given
	 *  a new size by its parent.
	 *
	 *  @param obj The Dynamic that changed.
	 */
	public function invalidateDisplayList(obj:ILayoutManagerClient ):Void
	{
        if (!_invalidateDisplayListFlag && _systemManager != null)
		{
			_invalidateDisplayListFlag = true;

			if (!_listenersAttached)
			{
                attachListeners(_systemManager);
			}
		}
        else if (!_invalidateDisplayListFlag && _systemManager == null)
		{
		}

		_invalidateDisplayListQueue.addObject(obj, obj.nestLevel);
	}

	//--------------------------------------------------------------------------
	//
	//  Methods: Commitment, measurement, layout, and drawing
	//
	//--------------------------------------------------------------------------

	/**
	 *  Validates all components whose properties have changed and have called
	 *  the <code>invalidateProperties()</code> method.  
	 *  It calls the <code>validateProperties()</code> method on those components
	 *  and will call <code>validateProperties()</code> on any other components that are 
	 *  invalidated while validating other components.
	 */
	private function validateProperties():Void
	{
		// Keep traversing the _invalidatePropertiesQueue until we've reached the end.
		// More elements may get added to the queue while we're in this loop, or a
		// a recursive call to this function may remove elements from the queue while
		// we're in this loop.
		
		while (true)
		{
			var obj:ILayoutManagerClient = _invalidatePropertiesQueue.removeSmallest();
			if (obj == null)
			{
				break;
			}
			obj.validateProperties();
			if (!obj.updateCompletePendingFlag)
			{
				_updateCompleteQueue.addObject(obj, obj.nestLevel);
				obj.updateCompletePendingFlag = true;
			}
		}

		if (_invalidatePropertiesQueue.isEmpty)
		{
			_invalidatePropertiesFlag = false;
		}
	}

	/**
	 *  Validates all components whose properties have changed and have called
	 *  the <code>invalidateSize()</code> method.  
	 *  It calls the <code>validateSize()</code> method on those components
	 *  and will call the <code>validateSize()</code> method 
	 *  on any other components that are 
	 *  invalidated while validating other components.  
	 *  The </code>validateSize()</code> method  starts with
	 *  the most deeply nested child in the tree of display Dynamics
	 */
	private function validateSize():Void
	{
		while (true)
		{
			var obj = _invalidateSizeQueue.removeLargest();
			if (obj == null)
			{
				break;
			}
			obj.validateSize();
			if (!obj.updateCompletePendingFlag)
			{
				_updateCompleteQueue.addObject(obj, obj.nestLevel);
				obj.updateCompletePendingFlag = true;
			}
		}
		
		if (_invalidateSizeQueue.isEmpty)
		{
			_invalidateSizeFlag = false;
		}
	}

	/**
	 *  Validates all components whose properties have changed and have called
	 *  the <code>invalidateDisplayList()</code> method.  
	 *  It calls <code>validateDisplayList()</code> method on those components
	 *  and will call the <code>validateDisplayList()</code> method 
	 *  on any other components that are 
	 *  invalidated while validating other components.  
	 *  The <code>validateDisplayList()</code> method starts with
	 *  the least deeply nested child in the tree of display Dynamics
	 */
	private function validateDisplayList():Void
	{
		while (true)
		{
			var obj:ILayoutManagerClient = _invalidateDisplayListQueue.removeSmallest();
			if (obj == null)
			{
				break;
			}
			obj.validateDisplayList();
			if (!obj.updateCompletePendingFlag)
			{
				_updateCompleteQueue.addObject(obj, obj.nestLevel);
				obj.updateCompletePendingFlag = true;
			}
		}
		
		if (_invalidateDisplayListQueue.isEmpty)
		{
			_invalidateDisplayListFlag = false;
		}
	}

	/**
	 *  @private
	 */
    private function doPhasedInstantiation():Void
	{
		// If phasing, do only one phase: validateProperties(),
		// validateSize(), or validateDisplayList().
		if (usePhasedInstantiation)
		{
			if (_invalidatePropertiesFlag)
			{
				validateProperties();

				// The Preloader listens for this event.
                _systemManager.document.dispatchEvent(
					new Event("validatePropertiesComplete"));
			}
			else if (_invalidateSizeFlag)
			{
				validateSize();

				// The Preloader listens for this event.
                _systemManager.document.dispatchEvent(
					new Event("validateSizeComplete"));
			}
			else if (_invalidateDisplayListFlag)
			{
				validateDisplayList();

				// The Preloader listens for this event.
                _systemManager.document.dispatchEvent(
					new Event("validateDisplayListComplete"));
			}
		}

		// Otherwise, do one pass of all three phases.
		else
		{
			if (_invalidatePropertiesFlag)
				validateProperties();

			if (_invalidateSizeFlag)
				validateSize();

			if (_invalidateDisplayListFlag)
				validateDisplayList();
		}

		if (_invalidatePropertiesFlag ||
			_invalidateSizeFlag ||
			_invalidateDisplayListFlag)
		{
            attachListeners(_systemManager);
		}
		else
		{
			usePhasedInstantiation = false;

			_listenersAttached = false;

			var obj:ILayoutManagerClient = _updateCompleteQueue.removeLargest();
			while (obj != null)
			{
				if (!obj.initialized && obj.processedDescriptors)
					obj.initialized = true;
                if (obj.hasEventListener(FlexEvent.UPDATE_COMPLETE))
				    obj.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
				obj.updateCompletePendingFlag = false;
				obj = _updateCompleteQueue.removeLargest();
			}
			dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
		}
	}

	/**
	 *  When properties are changed, components generally do not apply those changes immediately.
	 *  Instead the components usually call one of the LayoutManager's invalidate methods and
	 *  apply the properties at a later time.  The actual property you set can be read back
	 *  immediately, but if the property affects other properties in the component or its
	 *  children or parents, those other properties may not be immediately updated.  To
	 *  guarantee that the values are updated, you can call the <code>validateNow()</code> method.  
	 *  It updates all properties in all components before returning.  
	 *  Call this method only when necessary as it is a computationally intensive call.
	 */
	public function validateNow():Void
	{
		if (!usePhasedInstantiation)
		{
			var infiniteLoopGuard:Int = 0;
			while (_listenersAttached && infiniteLoopGuard++ < 100)
				doPhasedInstantiation();
		}
	}

	/**
	 *  When properties are changed, components generally do not apply those changes immediately.
	 *  Instead the components usually call one of the LayoutManager's invalidate methods and
	 *  apply the properties at a later time.  The actual property you set can be read back
	 *  immediately, but if the property affects other properties in the component or its
	 *  children or parents, those other properties may not be immediately updated.  
	 *
	 *  <p>To guarantee that the values are updated, 
	 *  you can call the <code>validateClient()</code> method.  
	 *  It updates all properties in all components whose nest level is greater than or equal
	 *  to the target component before returning.  
	 *  Call this method only when necessary as it is a computationally intensive call.</p>
	 *
	 *  @param target The component passed in is used to test which components
	 *  should be validated.  All components contained by this component will have their
	 *  <code>validateProperties()</code>, <code>commitProperties()</code>, 
	 *  <code>validateSize()</code>, <code>measure()</code>, 
	 *  <code>validateDisplayList()</code>, 
	 *  and <code>updateDisplayList()</code> methods called.
	 *
	 *	@param skipDisplayList If <code>true</code>, 
	 *  does not call the <code>validateDisplayList()</code> 
	 *  and <code>updateDisplayList()</code> methods.
	 */
	public function validateClient(target:ILayoutManagerClient, skipDisplayList:Bool = false):Void
	{
		var obj:ILayoutManagerClient;
		var i:Int = 0;
		var done:Bool = false;
		var oldTargetLevel:Int = _targetLevel;

		// the theory here is that most things that get validated are deep in the tree
		// and so there won't be nested calls to validateClient.  However if there is,
		// we don't want to have a more sophisticated scheme of keeping track
		// of dirty flags at each level that is being validated, but we definitely
		// do not want to keep scanning the queues unless we're pretty sure that
		// something might be dirty so we just say that if something got dirty
		// during this call at a deeper nesting than the first call to validateClient
		// then we'll scan the queues.  So we only change targetLevel if we're the
		// outer call to validateClient and only that call restores it.
		if (_targetLevel == CMath.INT_MAX_VALUE)
			_targetLevel = target.nestLevel;

		while (!done)
		{
			// assume we won't find anything
			done = true;

			// Keep traversing the _invalidatePropertiesQueue until we've reached the end.
			// More elements may get added to the queue while we're in this loop, or a
			// a recursive call to this function may remove elements from the queue while
			// we're in this loop.
			obj = _invalidatePropertiesQueue.removeSmallestChild(target);
			while (obj != null)
			{
				obj.validateProperties();
				if (!obj.updateCompletePendingFlag)
				{
					_updateCompleteQueue.addObject(obj, obj.nestLevel);
					obj.updateCompletePendingFlag = true;
				}

				// Once we start, don't stop.
				obj = _invalidatePropertiesQueue.removeSmallestChild(target);
			}

			if (_invalidatePropertiesQueue.isEmpty)
			{
				_invalidatePropertiesFlag = false;
				_invalidateClientPropertiesFlag = false;
			}

			obj = _invalidateSizeQueue.removeLargestChild(target);
			while (obj != null)
			{
				obj.validateSize();
				if (!obj.updateCompletePendingFlag)
				{
					_updateCompleteQueue.addObject(obj, obj.nestLevel);
					obj.updateCompletePendingFlag = true;
				}
				
				if (_invalidateClientPropertiesFlag)
				{
					// did any properties get invalidated while validating size?
					obj = _invalidatePropertiesQueue.removeSmallestChild(target);
					if (obj != null)
					{
						// re-queue it. we'll pull it at the beginning of the loop
						_invalidatePropertiesQueue.addObject(obj, obj.nestLevel);
						done = false;
						break;
					}
				}
				
				obj = _invalidateSizeQueue.removeLargestChild(target);
			}

			if (_invalidateSizeQueue.isEmpty)
			{
				_invalidateSizeFlag = false;
				_invalidateClientSizeFlag = false;
			}

			if (!skipDisplayList)
			{
				obj = _invalidateDisplayListQueue.removeSmallestChild(target);
				while (obj != null)
				{
					obj.validateDisplayList();
					if (!obj.updateCompletePendingFlag)
					{
						_updateCompleteQueue.addObject(obj, obj.nestLevel);
						obj.updateCompletePendingFlag = true;
					}

					if (_invalidateClientPropertiesFlag)
					{
						obj = _invalidatePropertiesQueue.removeSmallestChild(target);
						if (obj != null)
						{
							// re-queue it. we'll pull it at the beginning of the loop
							_invalidatePropertiesQueue.addObject(obj, obj.nestLevel);
							done = false;
							break;
						}
					}

					if (_invalidateClientSizeFlag)
					{
						obj = _invalidateSizeQueue.removeLargestChild(target);
						if (obj != null)
						{
							// re-queue it. we'll pull it at the beginning of the loop
							_invalidateSizeQueue.addObject(obj, obj.nestLevel);
							done = false;
							break;
						}
					}

					// Once we start, don't stop.
					obj = _invalidateDisplayListQueue.removeSmallestChild(target);
				}


				if (_invalidateDisplayListQueue.isEmpty)
				{
					_invalidateDisplayListFlag = false;
				}
			}
		}

		if (oldTargetLevel == CMath.INT_MAX_VALUE)
		{
			_targetLevel = CMath.INT_MAX_VALUE;
			if (!skipDisplayList)
			{
				
				while (true)
				{
					var obj = _updateCompleteQueue.removeLargestChild(target);
					if (obj == null)
					{
						break;
					}
					
					if (!obj.initialized)
						obj.initialized = true;
                    
                    if (obj.hasEventListener(FlexEvent.UPDATE_COMPLETE))
					    obj.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
					obj.updateCompletePendingFlag = false;
				}
			}
		}
	}

	/**
	 *  Returns <code>true</code> if there are components that need validating;
	 *  <code>false</code> if all components have been validated.
         *
         *  @return Returns <code>true</code> if there are components that need validating;
	 *  <code>false</code> if all components have been validated.
	 */
	public function isInvalid():Bool
	{
		return _invalidatePropertiesFlag ||
			   _invalidateSizeFlag ||
			   _invalidateDisplayListFlag;
	}

	/**
	 *  @private
	 *  callLater() is called immediately after an Dynamic is created.
	 *  We really want to wait one more frame before starting in.
	 */
	private function waitAFrame(event:Event):Void
	{
        _systemManager.removeEventListener(Event.ENTER_FRAME, waitAFrame);
        _systemManager.addEventListener(Event.ENTER_FRAME, doPhasedInstantiationCallback);
        _waitedAFrame = true;
	}

    private function attachListeners(systemManager:SystemManager):Void
	{
		if (!_waitedAFrame)
		{
            systemManager.addEventListener(Event.ENTER_FRAME, waitAFrame);
		}
		else
		{
            systemManager.addEventListener(Event.ENTER_FRAME, doPhasedInstantiationCallback);
			if (!usePhasedInstantiation)
			{
				if (systemManager.stage != null)
				{
                    systemManager.addEventListener(Event.RENDER, doPhasedInstantiationCallback);
					systemManager.stage.invalidate();
				}
			}
		}

		_listenersAttached = true;
	}

    private function doPhasedInstantiationCallback(event:Event):Void
    {
        _systemManager.removeEventListener(Event.ENTER_FRAME, doPhasedInstantiationCallback);
        _systemManager.removeEventListener(Event.RENDER, doPhasedInstantiationCallback);
		
        doPhasedInstantiation();
    }
}