package temperate.layouts;

enum ExcessSpaceMode 
{
	UNIFORM;
	INCREASE_GAPS;
	COMPACT_CONTAINER;
	MOVE_TO_EDGES(align:Float);
}