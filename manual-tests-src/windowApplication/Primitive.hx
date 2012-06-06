package windowApplication;

enum Primitive 
{
	MOVE_TO(x:Float, y:Float);
	LINE_TO(x:Float, y:Float);
	ELLIPSE(x:Float, y:Float, width:Float, height:Float);
	RECT(x:Float, y:Float, width:Float, height:Float);
	LINE_STYLE(color:Int);
	TF(x:Float, y:Float, width:Float, height:Float, text:String, color:Int);
}