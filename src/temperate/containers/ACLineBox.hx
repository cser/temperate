package temperate.containers;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.TypedDictionary;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.layouts.ICLineLayout;
import temperate.layouts.parametrization.CChildWrapper;

class ACLineBox extends CSprite, implements ICInvalidateClient
{
	public function new(layout:ICLineLayout) 
	{
		super();
		_layout = layout;
		_wrapperByChild = new TypedDictionary();
		_indentLeft = 0;
		_indentRight = 0;
		_indentTop = 0;
		_indentBottom = 0;
	}
	
	var _layout:ICLineLayout;
	
	var _wrapperByChild:TypedDictionary<DisplayObject, CChildWrapper>;
	
	public function add(child:DisplayObject):CChildWrapper
	{
		var wrapper = new CChildWrapper(child);
		super.addChild(child);
		_layout.add(wrapper);
		_size_valid = false;
		postponeSize();
		_wrapperByChild.set(child, wrapper);
		return wrapper;
	}
	
	override public function addChild(child:DisplayObject):DisplayObject
	{
		super.addChild(child);
		var wrapper = new CChildWrapper(child);
		_layout.add(wrapper);
		_size_valid = false;
		postponeSize();
		_wrapperByChild.set(child, wrapper);
		return child;
	}
	
	override public function addChildAt(child:DisplayObject, index:Int):DisplayObject
	{
		super.addChildAt(child, index);
		var wrapper = new CChildWrapper(child);
		_layout.addAt(wrapper, index);
		_size_valid = false;
		postponeSize();
		_wrapperByChild.set(child, wrapper);
		return child;
	}
	
	override public function removeChild(child:DisplayObject):DisplayObject
	{
		super.removeChild(child);
		var wrapper = _wrapperByChild.get(child);
		_wrapperByChild.delete(child);
		_layout.remove(wrapper);
		_size_valid = false;
		postponeSize();
		return child;
	}
	
	override public function removeChildAt(index:Int):DisplayObject
	{
		var child = getChildAt(index);
		super.removeChildAt(index);
		var wrapper = _wrapperByChild.get(child);
		_wrapperByChild.delete(child);
		_layout.remove(wrapper);
		_size_valid = false;
		postponeSize();
		return child;
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_layout.width = CMath.max(_settedWidth - _indentLeft - _indentRight, 0);
			_layout.height = CMath.max(_settedHeight - _indentTop - _indentBottom, 0);
			_layout.arrange(_indentLeft, _indentTop);
			_width = _indentLeft + _layout.width + _indentRight;
			_height = _indentTop + _layout.height + _indentBottom;
		}
	}
	
	override function get_isCompactWidth()
	{
		return _layout.isCompactWidth;
	}
	
	override function get_isCompactHeight()
	{
		return _layout.isCompactHeight;
	}
	
	override public function setCompact(isCompactWidth:Bool, isCompactHeight:Bool)
	{
		_layout.isCompactHeight = isCompactHeight;
		_layout.isCompactWidth = isCompactWidth;
		
		_size_valid = false;
		postponeSize();
	}
	
	public var indentLeft(get_indentLeft, null):Int;
	var _indentLeft:Int;
	function get_indentLeft()
	{
		return _indentLeft;
	}
	
	public var indentRight(default, null):Int;
	var _indentRight:Int;
	function get_indentRight()
	{
		return _indentRight;
	}
	
	public var indentTop(default, null):Int;
	var _indentTop:Int;
	function get_indentTop()
	{
		return _indentTop;
	}
	
	public var indentBottom(default, null):Int;
	var _indentBottom:Int;
	function get_indentBottom()
	{
		return _indentBottom;
	}
	
	public function setIndents(left:Int, right:Int, top:Int, bottom:Int):Void
	{
		_indentLeft = left;
		_indentRight = right;
		_indentTop = top;
		_indentBottom = bottom;
		
		_size_valid = false;
		postponeSize();
	}
	
	public var gapX(getGapX, setGapX):Float;
	function getGapX()
	{
		return _layout.gapX;
	}
	function setGapX(value)
	{
		_layout.gapX = value;
		_size_valid = false;
		postponeSize();
		return value;
	}
	
	public var gapY(getGapY, setGapY):Float;
	function getGapY()
	{
		return _layout.gapY;
	}
	function setGapY(value)
	{
		_layout.gapY = value;
		_size_valid = false;
		postponeSize();
		return value;
	}
	
	/**
	 * Call it directly if child sizes changed and need update layout
	 */
	public function invalidate():Void
	{
		_size_valid = false;
		postponeSize();
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function addTo(parent:DisplayObjectContainer, x:Float = 0, y:Float = 0):ACLineBox
	{
		this.x = x;
		this.y = y;
		parent.addChild(this);
		return this;
	}
}