package temperate.collections;

interface ICComponent< T:ICComponent<T> >
{
	var next:T;
}