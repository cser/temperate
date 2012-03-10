package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import temperate.containers.CVBox;
import temperate.core.CMath;
import temperate.extra.CKey;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.minimal.MTextArea;

class TestKey extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _key:CKey;
	var _log:MTextArea;
	
	public function init()
	{
		_key = CKey.getInstance();
		_key.init(stage);
		
		var main = new CVBox().addTo(this, 20, 15);
		new MButton().setText("Check space down").addClickHandler(onCheckSpaceDownClick)
			.addTo(main);
		
		_log = new MTextArea();
		_log.setSize(200, 300);
		main.add(_log);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, CMath.INT_MAX_VALUE - 1);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, CMath.INT_MAX_VALUE - 1);
	}
	
	function onCheckSpaceDownClick(event:Event)
	{
		log("space down: " + _key.isDown(" ".charCodeAt(0)));
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		var keyCode = event.keyCode;
		log("onKeyDown: isDown(" + keyCode + ")=" + _key.isDown(keyCode));
	}
	
	function onKeyUp(event:KeyboardEvent)
	{
		var keyCode = event.keyCode;
		log("onKeyUp: isDown(" + keyCode + ")=" + _key.isDown(keyCode));
	}
	
	function log(text)
	{
		_log.appendText(text + "\n");
		_log.vScrollValue = CMath.INT_MAX_VALUE;
	}
}