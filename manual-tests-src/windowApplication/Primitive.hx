package windowApplication;

enum Primitive 
{
	MOVE_TO(x:Float, y:Float);
	LINE_TO(x:Float, y:Float);
	ELLIPSE(x:Float, y:Float, width:Float, height:Float);
	RECT(x:Float, y:Float, width:Float, height:Float);
}