package flexReverse;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.TypedDictionary;

/**
 *  The PriorityQueue class provides a general purpose priority queue.
 *  It is used internally by the LayoutManager.
 */
class PriorityQueue
{
    public function new()
    {
		_arrayOfDictionaries = [];
		_minPriority = 0;
		_maxPriority = 0;
		generation = 0;
    }
	
    var _arrayOfDictionaries:Array<ArrayItem>;

    /**
     *  The smallest occupied index in arrayOfDictionaries.
     */
    var _minPriority:Int;
    
    /**
     *  The largest occupied index in arrayOfDictionaries.
     */
    var _maxPriority:Int;

    /**
     *  Used to keep track of change deltas.
     */
    public var generation:Int;
	
    public function addObject(obj:ILayoutManagerClient, priority:Int):Void
    {       
        // If no hash exists for the specified priority, create one.
        if (_arrayOfDictionaries[priority] == null)
        {
            _arrayOfDictionaries[priority] = new ArrayItem();
            _arrayOfDictionaries[priority].length = 0;
            _arrayOfDictionaries[priority].items = new TypedDictionary();
        }

        // If we don't already hold the obj in the specified hash, add it
        // and update our item count.
        if (_arrayOfDictionaries[priority].items.get(obj) == null)
        { 
            _arrayOfDictionaries[priority].items.set(obj, true);
            _arrayOfDictionaries[priority].length++;
        }
       
        // Update our min and max priorities.
        if (_maxPriority < _minPriority)
        {
            _minPriority = _maxPriority = priority;
        }
        else
        {
            if (priority < _minPriority)
                _minPriority = priority;
            if (priority > _maxPriority)
                _maxPriority = priority;
        }
        
        // Update our changelist id since we've added an item.
        generation++;
    }

    public function removeLargest():ILayoutManagerClient
    {
        var obj:ILayoutManagerClient = null;

        if (_minPriority <= _maxPriority)
        {
            while (_arrayOfDictionaries[_maxPriority] == null || 
                   _arrayOfDictionaries[_maxPriority].length == 0)
            {
                _maxPriority--;
                if (_maxPriority < _minPriority)
                    return null;
            }
        
            // Remove the item with largest priority from our priority queue.
            // Must use a for loop here since we're removing a specific item
            // from a 'Dictionary' (no means of directly indexing).
            for (key in _arrayOfDictionaries[_maxPriority].items.keys())
            {
                obj = key;
                removeChild(key, _maxPriority);
                break;
            }

            // Update maxPriority if applicable.
            while (_arrayOfDictionaries[_maxPriority] == null || 
                   _arrayOfDictionaries[_maxPriority].length == 0)
            {
                _maxPriority--;
                if (_maxPriority < _minPriority)
                    break;
            }
            
        }
        
        return obj;
    }

    public function removeLargestChild(client:ILayoutManagerClient):ILayoutManagerClient
    {
        var max:Int = _maxPriority;
        var min:Int = client.nestLevel;

        while (min <= max)
        {
            if (_arrayOfDictionaries[max] != null && _arrayOfDictionaries[max].length > 0)
            {
                if (max == client.nestLevel)
                {
                    // If the current level we're searching matches that of our
                    // client, no need to search the entire list, just check to see
                    // if the client exists in the queue (it would be the only item
                    // at that nestLevel).
                    if (_arrayOfDictionaries[max].items.get(client))
                    {
                        removeChild(client, max);
                        return client;
                    }
                }
                else
                {
                    for (key in _arrayOfDictionaries[max].items.keys())
                    {
                        if (contains(client.displayObject, key.displayObject))
                        {
                            removeChild(key, max);
                            return key;
                        }
                    }
                }
                
                max--;
            }
            else
            {
                if (max == _maxPriority)
                    _maxPriority--;
                max--;
                if (max < min)
                    break;
            }           
        }

        return null;
    }
	
    public function removeSmallest():ILayoutManagerClient
    {
        var obj:ILayoutManagerClient = null;

        if (_minPriority <= _maxPriority)
        {
            while (_arrayOfDictionaries[_minPriority] == null || 
                   _arrayOfDictionaries[_minPriority].length == 0)
            {
                _minPriority++;
                if (_minPriority > _maxPriority)
                    return null;
            }           

            // Remove the item with smallest priority from our priority queue.
            // Must use a for loop here since we're removing a specific item
            // from a 'Dictionary' (no means of directly indexing).
            for (key in _arrayOfDictionaries[_minPriority].items.keys() )
            {
                obj = key;
                removeChild(key, _minPriority);
                break;
            }

            // Update minPriority if applicable.
            while (_arrayOfDictionaries[_minPriority] == null || 
                   _arrayOfDictionaries[_minPriority].length == 0)
            {
                _minPriority++;
                if (_minPriority > _maxPriority)
                    break;
            }           
        }

        return obj;
    }

    public function removeSmallestChild(client:ILayoutManagerClient):ILayoutManagerClient
    {
        var min:Int = client.nestLevel;

        while (min <= _maxPriority)
        {
            if (_arrayOfDictionaries[min] != null && _arrayOfDictionaries[min].length > 0)
            {   
                if (min == client.nestLevel)
                {
                    // If the current level we're searching matches that of our
                    // client, no need to search the entire list, just check to see
                    // if the client exists in the queue (it would be the only item
                    // at that nestLevel).
                    if (_arrayOfDictionaries[min].items.get(client))
                    {
                        removeChild(client, min);
                        return client;
                    }
                }
                else
                {
                    for (key in _arrayOfDictionaries[min].items.keys())
                    {
                        if (contains(client.displayObject, key.displayObject))
                        {
                            removeChild(key, min);
                            return key;
                        }
                    }
                }
                
                min++;
            }
            else
            {
                if (min == _minPriority)
                    _minPriority++;
                min++;
                if (min > _maxPriority)
                    break;
            }           
        }
        
        return null;
    }
	
    public function removeChild(client:ILayoutManagerClient, priority:Int):ILayoutManagerClient
    {
        if (_arrayOfDictionaries[priority] != null &&
            _arrayOfDictionaries[priority].items.get(client))
        {
            _arrayOfDictionaries[priority].items.delete(client);
            _arrayOfDictionaries[priority].length--;
            
            // Update our changelist id since we've removed an item.
            generation++;
            
            return client;
        }
        return null;
    }
    
    public function removeAll():Void
    {
        _arrayOfDictionaries.splice(0, _arrayOfDictionaries.length);
        _minPriority = 0;
        _maxPriority = -1;
        generation += 1;
    }
	
	public var isEmpty(get_isEmpty, null):Bool;
    function get_isEmpty():Bool
    {
        return _minPriority > _maxPriority;
    }
	
    function contains(parent:DisplayObject, child:DisplayObject):Bool
    {
        if (Std.is(parent, DisplayObjectContainer))
        {
            return cast(parent, DisplayObjectContainer).contains(child);
        }
        return parent == child;
    }
}
class ArrayItem
{
	public function new()
	{
	}
	
	public var length:Int;
	
	public var items:TypedDictionary<ILayoutManagerClient, Bool>;
}