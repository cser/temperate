package temperate.collections;

interface ICComponent< T:ICComponent<T> >
{
	var prev:T;
	var next:T;
}