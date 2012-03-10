package temperate.extra;
import haxe.macro.Context;
import haxe.macro.Expr;

/**
 * Check of listener type by event class.
 * Example:
 *     using seabattle.utils.EventDispatcherUtil;
 *     sprite._(++MouseEvent.CLICK, onMouseClick);// subscribe
 *     sprite._(--MouseEvent.CLICK, onMouseClick);// unsubscribe
 * Make compilation error if MouseEvent is not cast to onMouseClick parameter type
 */
class EventDispatcherUtil 
{
	@:macro public static function _(
		dispatcher:Expr,
		typeExpr:Expr,
		listener:ExprRequire < Dynamic->Void > ,
		?useCapture:ExprRequire<Bool>,
		?priority:ExprRequire<Int>,
		?useWeakReference:ExprRequire<Bool>):Expr
	{
		var methodName = null;
		var type = null;
		switch (typeExpr.expr)
		{
			case EUnop(opcode, postfix, expr):
				if (!postfix)
				{
					switch (opcode)
					{
						case OpIncrement:
							methodName = "addEventListener";
							type = expr;
						case OpDecrement:
							methodName = "removeEventListener";
							type = expr;
						default:
					}
				}
			default:
		}
		return if (methodName != null)
		{
			getExpr(
				dispatcher, type, listener, [useCapture, priority, useWeakReference], methodName);
		}
		else
		{
			Context.error("Expected ++/-- EventClass.EVENT_TYPE", typeExpr.pos);
			dispatcher;
		};
	}
	
	#if macro
	private static function getExpr(
		dispatcher:Expr, type:Expr, listener:Expr, additionParams:Array<Expr>,
		methodName:String):Expr
	{
		var params = [type, { expr:EConst(CIdent("__listener__")), pos:listener.pos } ];
		for (additionParam in additionParams)
		{
			var isNull = switch (additionParam.expr)
			{
				case EConst(constant):
					switch (constant)
					{
						case CIdent(ident): ident == "null";
						default: false;
					}
				default: false;
			}
			if (!isNull)
			{
				params.push(additionParam);
			}
		}
		var className = switch (type.expr)
		{
			case EType(expr, field):
				switch (expr.expr)
				{
					case EConst(constant):
						switch (constant)
						{
							case CType(s): s;
							default: null;
						}
					default: null;
				}
			default: null;
		};
		if (className == null)
		{
			Context.error("Exptected EventClass.EVENT_TYPE", type.pos);
			return dispatcher;
		}
		var pos = listener.pos;
		return {
			expr: EBlock([
				{
					expr: EVars([{
						name: "__listener__",
						type: TFunction(
							[TPath( { name: className, pack: [], params: [], sub: null } )],
							TPath( { name: "Void", pack: [], params: [], sub: null } )
						),
						expr: listener,
					}]),
					pos: pos
				},
				{
					expr: ECall(
						{ expr:EField(dispatcher, methodName), pos: dispatcher.pos },
						params
					),
					pos: dispatcher.pos
				}
			]),
			pos: pos
		};
	}
	#end
}