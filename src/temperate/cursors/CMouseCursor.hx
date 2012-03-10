package temperate.cursors;
#if nme
typedef CMouseCursor = String;
#else
	#if flash10
import flash.ui.MouseCursor;
typedef CMouseCursor = MouseCursor;
	#else
typedef CMouseCursor = String;
	#end
#end

