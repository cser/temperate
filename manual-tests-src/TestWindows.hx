package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.windows.CPopUpManager;
import windows.TestWindow;

class TestWindows extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _manager:CPopUpManager;
	
	public function init()
	{
		_manager = new CPopUpManager(this);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		var window = new TestWindow();
		_manager.add(window, true);
		
		var window = new TestWindow();
		window.move(15, 20);
		_manager.add(window, true);
	}
	
	function onStageResize(event:Event = null)
	{
		_manager.setArea(10, 10, stage.stageWidth - 10, stage.stageHeight - 10);
	}
}
/*
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