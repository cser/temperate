package temperate.core;

import haxe.PosInfos;
import massive.munit.Assert;

class CMathTest
{
	public function new()
	{
	}
	
	@Test
	public function colorConvertions()
	{
		Assert.areEqual(1, CMath.alphaPart(0xff000000));
		Assert.areEqual(1, CMath.alphaPart(0xffe0e0e0));
		Assert.areEqual(1, CMath.alphaPart(0xffffffff));
		
		Assert.areEqual(0, CMath.alphaPart(0x00000000));
		Assert.areEqual(0, CMath.alphaPart(0x00e0e0e0));
		Assert.areEqual(0, CMath.alphaPart(0x00ffffff));
		
		Assert.areEqual(.5, Math.round(CMath.alphaPart(0x80000000) * 10) / 10);
		Assert.areEqual(.5, Math.round(CMath.alphaPart(0x80e0e0e0) * 10) / 10);
		Assert.areEqual(.5, Math.round(CMath.alphaPart(0x80ffffff) * 10) / 10);
		
		Assert.areEqual(0x000000, CMath.colorPart(0xff000000));
		Assert.areEqual(0x000000, CMath.colorPart(0x00000000));
		Assert.areEqual(0x000000, CMath.colorPart(0x80000000));
		
		Assert.areEqual(0xffffff, CMath.colorPart(0xffffffff));
		Assert.areEqual(0xffffff, CMath.colorPart(0x00ffffff));
		Assert.areEqual(0xffffff, CMath.colorPart(0x80ffffff));
		
		Assert.areEqual(0x808080, CMath.colorPart(0xff808080));
		Assert.areEqual(0x808080, CMath.colorPart(0x00808080));
		Assert.areEqual(0x808080, CMath.colorPart(0x80808080));
	}
	
	@Test
	public function fullColor()
	{
		ExtendedAssert.areUIntEqual(0xff808080, CMath.fullColor(0x808080, 1));
		ExtendedAssert.areUIntEqual(0xff000000, CMath.fullColor(0x000000, 1));
		ExtendedAssert.areUIntEqual(0xffffffff, CMath.fullColor(0xffffff, 1));
		
		ExtendedAssert.areUIntEqual(0x7f808080, CMath.fullColor(0x80808080, .5));
		ExtendedAssert.areUIntEqual(0x7fffffff, CMath.fullColor(0x80ffffff, .5));
		ExtendedAssert.areUIntEqual(0x00808080, CMath.fullColor(0xff808080, 0));
		ExtendedAssert.areUIntEqual(0x00ffffff, CMath.fullColor(0xffffffff, 0));
	}
	
	@Test
	public function toPrecisionString()
	{
		Assert.areEqual("1.00", CMath.toFixed(1, 2));
		Assert.areEqual("1.50", CMath.toFixed(1.501, 2));
		Assert.areEqual("2", CMath.toFixed(1.501, 0));
		
		Assert.areEqual("2", CMath.toPrecision(1.501, 1));
		Assert.areEqual("1.50", CMath.toPrecision(1.501, 3));
		Assert.areEqual("1.501", CMath.toPrecision(1.501, 4));
		Assert.areEqual("1.000", CMath.toPrecision(1, 4));
		
		Assert.areEqual("1", CMath.toLimitDigits(1, 2));
		Assert.areEqual("2", CMath.toLimitDigits(1.501, 0));
		Assert.areEqual("1.5", CMath.toLimitDigits(1.501, 2));
		Assert.areEqual("1.501", CMath.toLimitDigits(1.501, 3));
	}
	
	@Test
	public function maxAndMin()
	{
		Assert.areEqual(1, CMath.min3(1, 2, 3));
		Assert.areEqual(1, CMath.min3(2, 1, 3));
		Assert.areEqual(1, CMath.min3(3, 2, 1));
		Assert.areEqual(1, CMath.min3(2, 2, 1));
		
		Assert.areEqual(3, CMath.max3(1, 2, 3));
		Assert.areEqual(3, CMath.max3(3, 1, 3));
		Assert.areEqual(3, CMath.max3(1, 3, 2));
		Assert.areEqual(3, CMath.max3(3, 1, 2));
		
		Assert.areEqual(1, CMath.intMin3(1, 2, 3));
		Assert.areEqual(1, CMath.intMin3(2, 1, 3));
		Assert.areEqual(1, CMath.intMin3(3, 2, 1));
		Assert.areEqual(1, CMath.intMin3(2, 2, 1));
		
		Assert.areEqual(3, CMath.intMax3(1, 2, 3));
		Assert.areEqual(3, CMath.intMax3(3, 1, 3));
		Assert.areEqual(3, CMath.intMax3(1, 3, 2));
		Assert.areEqual(3, CMath.intMax3(3, 1, 2));
	}
}