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
}