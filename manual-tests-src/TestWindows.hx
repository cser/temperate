package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.minimal.MSlider;
import temperate.windows.CPopUpManager;
import temperate.windows.docks.CPopUpAbsoluteDock;
import windows.TestWindow;

class TestWindows extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _manager:CPopUpManager;
	var _slider:MSlider;
	
	public function init()
	{
		_slider = new MSlider(true);
		_slider.value = 50;
		_slider.mouseWheelStep = 10;
		_slider.addEventListener(Event.CHANGE, onStageResize);
		addChild(_slider);
		
		_manager = new CPopUpManager(this);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		var window = new TestWindow();
		window.dock = new CPopUpAbsoluteDock();
		_manager.add(window, false);
		window.move(100, 100);
		
		var window = new TestWindow();
		_manager.add(window, false);
		
		var window = new TestWindow();
		_manager.add(window, false);
		window.move(100, 100);
	}
	
	function onStageResize(event:Event = null)
	{
		_manager.setArea(Std.int(_slider.value), 10, stage.stageWidth - 60, stage.stageHeight - 10);
		
		var g = graphics;
		g.clear();
		g.lineStyle(0, 0xcccccc);
		g.drawRect(0, 0, 100, 100);
		var x = _manager.areaX;
		var y = _manager.areaY;
		var width = _manager.areaWidth;
		var height = _manager.areaHeight;
		g.drawRect(x, y, width, height);
		g.moveTo(x, y);
		g.lineTo(x + width, y + height);
		g.moveTo(x + width, y);
		g.lineTo(x, y + height);
	}
}
/*
Починить дрейф выравнивания при изменении размеров границ
Окно-контейнер
Скинование окон с целью отвязать внешний вид окна от иерархии наследования
Возможность добавления отображаемых объектов, не являющихся окнами
Независимая работа нескольких оконных систем на одном контейнере,
который может содержать другие объекты
Подписка на клавиши, срабатывающие только для верхнего(активного) окна
Окна могут находиться в состояниях залочено, активно, неактивно
Активация незалоченных окон при клике по ним
Возможность отменить закрытие окна через события снаружи
События активации и деактивации окна
События открытия и закрытия окна (событие совершенного загрытия отличается от события закрывания)
Решить проблему подписки и отписки отдельно на каждый вариант закрытия окна, чтобы однозначно
определить результат закрытия окна
подписка на изменение размеров области для окон как снутри так и снаружи
Использование окна без скина
Изменение глобальной блокировки элементов под окнами
*/