This classes will be not used in temperate lib
(May be your are not want to use signals, or want use another signal lib).
It's just for using as separate lib
(Separated repository for one class is overhead)

Features:
- full compile-time type checking for listeners, arguments and arguments count;
- unlimited number of arguments (full type checked, signals without arguments is allowed as well);
- only one class

Shortcommings:
- works only for flashplayer9+

This is a extremely simple implementation of signals (no bubbling and etc).
It was made simple becouse:
- for more complex cases using native flashplayer9 events
  is better by all criterions (not only performance);
- other haxe libs do it (hsl-1, hsl-pico-1)

Examples of using see in test/src/temperate/signals/