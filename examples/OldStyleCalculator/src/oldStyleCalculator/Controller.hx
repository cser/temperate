package oldStyleCalculator;
import temperate.extra.CSignal;

class Controller 
{
	public var screenChanged(default, null):CSignal < Void->Void > ;
	
	public function new() 
	{
		screenChanged = new CSignal();
		screen = "0";
		_state = ControllerState.WAIT_INPUT;
	}
	
	public var screen(default, null):String;
	
	var _state:ControllerState;
	
	public function backspace()
	{
		screen = screen.substr(0, screen.length - 1);
		if (screen == "")
		{
			screen = "0";
		}
		screenChanged.dispatch();
	}
	
	public function resetAll()
	{
		_state = ControllerState.WAIT_INPUT;
		_operation = null;
		_firstArgument = Math.NaN;
		screen = "0";
		screenChanged.dispatch();
	}
	
	public function clearCurrent()
	{
		screen = "0";
		screenChanged.dispatch();
	}
	
	public function addSymbol(symbol:String)
	{
		switch (_state)
		{
			case ControllerState.WAIT_INPUT, ControllerState.INPUT_SECOND_ARGUMENT:
				if (symbol == "." && screen.indexOf(".") != -1)
				{
					return;
				}
				if (screen == "0")
				{
					screen = symbol;
				}
				else
				{
					screen += symbol;
				}
			case ControllerState.OPERATION_SELECTED:
				screen = symbol;
				_state = ControllerState.INPUT_SECOND_ARGUMENT;
			case ControllerState.RESULT:
				screen = symbol;
		}
		screenChanged.dispatch();
	}
	
	var _firstArgument:Float;
	var _secondArgument:Float;
	var _operation:Operation;
	
	public function addOperation(operation:Operation)
	{
		switch (_state)
		{
			case ControllerState.WAIT_INPUT:
			case ControllerState.OPERATION_SELECTED:
			case ControllerState.INPUT_SECOND_ARGUMENT:
				calculate();
			case ControllerState.RESULT:
		}
		
		_firstArgument = Std.parseFloat(screen);
		_operation = operation;
		_state = ControllerState.OPERATION_SELECTED;
	}
	
	public function calculate()
	{
		switch (_state)
		{
			case ControllerState.WAIT_INPUT:
				return;
			case ControllerState.OPERATION_SELECTED, ControllerState.INPUT_SECOND_ARGUMENT:
				_secondArgument = Std.parseFloat(screen);
				screen = Std.string(_operation.calculate(_firstArgument, _secondArgument));
			case ControllerState.RESULT:
				screen = Std.string(_operation.calculate(Std.parseFloat(screen), _secondArgument));
		}
		_state = ControllerState.RESULT;
		screenChanged.dispatch();
	}
}