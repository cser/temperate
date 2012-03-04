package temperate.minimal.windows;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.collections.CObjectHash;
import temperate.containers.CHBox;
import temperate.minimal.MButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MSeparator;

class MAlert< TData > extends AMWindow<TData>
{
	public static var okName = "OK";
	
	public static var maxTextWidth = 300;
	
	public static function show< TData >(
		modal:Bool,
		text:String, title:String = null, buttons:Array<MButtonInfo<TData>> = null,
		crossData:TData = null, crossShow:Bool = true, image:DisplayObject = null):MAlert<TData>
	{
		var alert = new MAlert(text, title, buttons, crossData, crossShow, image);
		MWindowManager.add(alert, modal);
		return alert;
	}
	
	public function new(
		text:String, title:String, buttons:Array<MButtonInfo<TData>>,
		crossData:TData, crossShow:Bool, image:DisplayObject)
	{
		super();
		
		if (buttons == null)
		{
			buttons = [ new MButtonInfo(null, okName) ];
		}
		
		this.title = title != null ? title : " ";
		
		var line = new CHBox();
		_main.add(line).setPercents(100);
		
		if (image != null)
		{
			line.add(image);
		}
		
		_tf = MFormatFactory.LABEL.newAutoSized(false);
		_tf.text = text != null ? text : "" + text;
		if (_tf.width > maxTextWidth)
		{
			_tf.wordWrap = true;
			_tf.width = maxTextWidth;
		}
		line.add(_tf);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var line = new CHBox();
		_main.add(line).setAlign(.5);
		
		_dataByButton = new CObjectHash();
		for (info in buttons)
		{
			var button = new MButton();
			button.width = 50;
			button.text = info.name;
			button.addEventListener(MouseEvent.CLICK, onButtonClick);
			if (info.selected)
			{
				button.selected = true;
			}
			line.add(button);
			_dataByButton.set(button, info.data);
		}
		if (crossShow)
		{
			var button = _skin.closeButton;
			_skin.addHeadButton(button);
			_dataByButton.set(button, crossData);
			button.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
	}
	
	var _tf:TextField;
	var _dataByButton:CObjectHash<Dynamic, TData>;
	
	public var selectable(get_selectable, set_selectable):Bool;
	function get_selectable()
	{
		return _tf.selectable;
	}
	function set_selectable(value)
	{
		_tf.selectable = value;
		return value;
	}
	
	function onButtonClick(event:MouseEvent)
	{
		var data = _dataByButton.get(event.currentTarget);
		close(data);
	}
}