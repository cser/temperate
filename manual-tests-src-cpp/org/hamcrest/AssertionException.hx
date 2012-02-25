/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;
import haxe.PosInfos;

class AssertionException extends Exception
{
	public function new(?message:String="", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}