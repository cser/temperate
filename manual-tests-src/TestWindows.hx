package ;
import flash.display.Sprite;
import temperate.windows.CWindowManager;

class TestWindows extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var manager = new CWindowManager();
	}
}
/*
Возможность добавления отображаемых объектов, не являющихся окнами
Независимая работа нескольких оконных систем на одном контейнере,
который может содержать другие объекты
Подписка на клавиши, срабатывающие только для верхнего(активного) окна
Окна могут находиться в состояниях залочено, активно, неактивно
Активация незалоченных окон при клике по ним
Возможность отменить закрытие окна через события снаружи
События открытия и закрытия окна
Решить проблему подписки и отписки отдельно на каждый вариант закрытия окна, чтобы однозначно
определить результат закрытия окна
подписка на изменение размеров области для окон как снутри так и снаружи
*/