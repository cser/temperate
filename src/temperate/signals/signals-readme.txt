This classes mast not used in other lib.
It's just for using as separate lib

Features:
- full type checking for listeners, arguments and arguments count;
- unlimited number of arguments;
- only one class

Shortcommings:
- works only for flashplayer9+

This is a extremely simple implementation of signals
(no bubbling and etc).
It makes simple becouse:
- for more complex cases using native flashplayer9 events
  is better by all criterions (not only performance);
- other haxe libs do it (hsl-1, hsl-pico-1)