package temperate.core;

import massive.munit.Assert;

class CMathTest
{
	public function new()
	{
	}
	
	@Test
	public function colorConvertions()
	{
		Assert.areEqual(1, CMath.getAlpha(0xff000000));
		Assert.areEqual(1, CMath.getAlpha(0xffe0e0e0));
		Assert.areEqual(1, CMath.getAlpha(0xffffffff));
		
		Assert.areEqual(0, CMath.getAlpha(0x00000000));
		Assert.areEqual(0, CMath.getAlpha(0x00e0e0e0));
		Assert.areEqual(0, CMath.getAlpha(0x00ffffff));
		
		Assert.areEqual(.5, Math.round(CMath.getAlpha(0x80000000) * 10) / 10);
		Assert.areEqual(.5, Math.round(CMath.getAlpha(0x80e0e0e0) * 10) / 10);
		Assert.areEqual(.5, Math.round(CMath.getAlpha(0x80ffffff) * 10) / 10);
		
		Assert.areEqual(0x000000, CMath.getColor(0xff000000));
		Assert.areEqual(0x000000, CMath.getColor(0x00000000));
		Assert.areEqual(0x000000, CMath.getColor(0x80000000));
		
		Assert.areEqual(0xffffff, CMath.getColor(0xffffffff));
		Assert.areEqual(0xffffff, CMath.getColor(0x00ffffff));
		Assert.areEqual(0xffffff, CMath.getColor(0x80ffffff));
		
		Assert.areEqual(0x808080, CMath.getColor(0xff808080));
		Assert.areEqual(0x808080, CMath.getColor(0x00808080));
		Assert.areEqual(0x808080, CMath.getColor(0x80808080));
	}
	
	@Test
	public function fullColor()
	{
		ExtendedAssert.areUIntEqual(0xff808080, CMath.applyAlpha(0x808080, 1));
		ExtendedAssert.areUIntEqual(0xff000000, CMath.applyAlpha(0x000000, 1));
		ExtendedAssert.areUIntEqual(0xffffffff, CMath.applyAlpha(0xffffff, 1));
		
		ExtendedAssert.areUIntEqual(0x7f808080, CMath.applyAlpha(0x80808080, .5));
		ExtendedAssert.areUIntEqual(0x7fffffff, CMath.applyAlpha(0x80ffffff, .5));
		ExtendedAssert.areUIntEqual(0x00808080, CMath.applyAlpha(0xff808080, 0));
		ExtendedAssert.areUIntEqual(0x00ffffff, CMath.applyAlpha(0xffffffff, 0));
	}
	
	@Test
	public function toPrecisionString()
	{
		Assert.areEqual("1.00", CMath.toFixed(1, 2));
		Assert.areEqual("1.50", CMath.toFixed(1.501, 2));
		Assert.areEqual("2", CMath.toFixed(1.501, 0));
		Assert.areEqual("0.", CMath.toFixed(0.499, 0));
		Assert.areEqual("0.02", CMath.toFixed(0.019, 2));
		Assert.areEqual("0.11", CMath.toFixed(0.11, 2));
		Assert.areEqual("0.1", CMath.toFixed(0.11, 1));
		Assert.areEqual("0.0", CMath.toFixed(.0, 1));
		Assert.areEqual("0.00", CMath.toFixed(.0, 2));
		Assert.areEqual("135.11", CMath.toFixed(135.111111, 2));
		
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
	
	@Test
	public function toString16Cases()
	{
		Assert.areEqual("0", CMath.toHex(0));
		Assert.areEqual("1", CMath.toHex(1));
		Assert.areEqual("a", CMath.toHex(10));
		Assert.areEqual("ff", CMath.toHex(0xff));
		Assert.areEqual("abcdef", CMath.toHex(0xabcdef));
		Assert.areEqual("a1b2c3", CMath.toHex(0xa1b2c3));
		Assert.areEqual("1023456", CMath.toHex(0x1023456));
		Assert.areEqual("789", CMath.toHex(0x789));
	}
}