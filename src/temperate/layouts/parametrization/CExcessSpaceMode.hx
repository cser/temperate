package temperate.layouts.parametrization;

enum CExcessSpaceMode 
{
	UNIFORM;
	INCREASE_GAPS;
	COMPACT_CONTAINER;
	MOVE_TO_EDGES(align:Float);
}