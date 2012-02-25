/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;
import haxe.PosInfos;

class Exception 
{
	public var name(default, null):String; 
	public var message(default, null):String;        
	public var cause(default, null):Dynamic;         
	public var info(default, null):PosInfos; 
	 
	public function new(?message:String="", ?cause:Dynamic = null, ?info:PosInfos) 
	{ 
        this.name = Type.getClassName(Type.getClass(this)); 
        this.message = message; 
        this.cause = cause; 
        this.info = info; 
	} 
	 
	public function toString():String 
	{ 
        var str:String = name + ": " + message; 
        if (info != null) 
        	str += " at " + info.className + "#" + info.methodName + " (" + info.lineNumber + ")"; 
        if (cause != null) 
        	str += "\n\t Caused by: " + cause; 
        return str; 
	} 
}

class IllegalArgumentException extends Exception
{
	public function new(?message:String="Argument could not be processed.", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}

class MissingImplementationException extends Exception
{
	public function new(?message:String="Abstract method not overridden.", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}

class UnsupportedOperationException extends Exception
{
	public function new(?message:String="", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}
