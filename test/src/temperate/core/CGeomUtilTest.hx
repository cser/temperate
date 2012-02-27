package temperate.core;
import massive.munit.Assert;
using massive.munit.Assert;

class CGeomUtilTest
{
	public function new()
	{
	}
	
	@Test
	public function rectangularTriangleCases()
	{
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 1, 1).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 1, -1).isFalse();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, -1, 1).isFalse();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, -1, -1).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 1, 16).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 3, 16).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 5, 9).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 5, 11).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 7, 4).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 9, 4).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 1, 16).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, -1, 16).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 5, 1).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, 0, 20, 5, -1).isFalse();
	}
	
	@Test
	public function obtuseTriangleCases()
	{
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 1, 1).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 0, -1).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 5, 1).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 5, -1).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 9, .1).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 10, -1).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, -4, 5).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, -6, 5).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, -1, 5).isTrue();
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 1, 5).isFalse();
		
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, -25, -20).isFalse();
		CGeomUtil.isInTriangle(0, 0, 10, 0, -10, 10, 20, -1).isFalse();
	}
	
	@Test
	public function isInConvexPoligon():Void
	{
		for (xys in [[1., 2, 2, 1, 5, 4, 2, 4], [2, 4, 5, 4, 2, 1, 1., 2]])
		{
			CGeomUtil.isInConvexPoligon(xys, 2, 1.5).isTrue();
			CGeomUtil.isInConvexPoligon(xys, 1.5, 2.5).isTrue();
			CGeomUtil.isInConvexPoligon(xys, 2.5, 2.5).isTrue();
			CGeomUtil.isInConvexPoligon(xys, 3, 3).isTrue();
			CGeomUtil.isInConvexPoligon(xys, 2, 3.5).isTrue();
			CGeomUtil.isInConvexPoligon(xys, 4, 3.5).isTrue();
			
			CGeomUtil.isInConvexPoligon(xys, 2, .5).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 1.2, 1.2).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 0, 2).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 1, 3).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 1, 4).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 1, 5).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 1.2, 3.5).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 3, 5).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 4, 5).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 6, 5).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 5, 3).isFalse();
			CGeomUtil.isInConvexPoligon(xys, 4, 2).isFalse();
		}
	}
	
	@Test
	public function getLineIntersect():Void
	{
		CGeomUtil.getLineIntersect(0, -1, 3, 2, 0, 3, 3, 0);
		Assert.areEqual(2, CGeomUtil.lineIntersectX);
		Assert.areEqual(1, CGeomUtil.lineIntersectY);
		
		CGeomUtil.getLineIntersect(0, -1, 0, 1, -1, 0, 1, 0);
		Assert.areEqual(0, CGeomUtil.lineIntersectX);
		Assert.areEqual(0, CGeomUtil.lineIntersectY);
		
		CGeomUtil.getLineIntersect(-1, 0, 1, 0, 0, -1, 0, 1);
		Assert.areEqual(0, CGeomUtil.lineIntersectX);
		Assert.areEqual(0, CGeomUtil.lineIntersectY);
	}
}