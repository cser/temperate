----------------------------------------------------------------------------------------------------
About
----------------------------------------------------------------------------------------------------
Temperate is a simple customizable GUI for flashplayer9+.
Tested with haXe 2.08

Site of project:
https://github.com/cser/temperate
	
Expamples of using:
https://github.com/cser/temperate/tree/develop/examples

Concept
	
* Library consists of 2 parts:
	
	1	All packages insteard of temperate.minimal
		
		This is classes for customizing, skinning and exstensions.
		No one class of other package is not depended on temperate.minimal, but temperate.minimal
		uses this classes
		
	2	Package temperate.minimal
		
		This is ready-to-use default-customized classes.
		They are not need any initialization.
		This classes was made for fast start work with lib or using in experiments/applications
		without requirements to spesial component skin

* Library is not depended to any other library, only for std haxe classes

----------------------------------------------------------------------------------------------------
Minimalcomps migration
----------------------------------------------------------------------------------------------------

minimalcomps			temperate
____________________________________________________________________
BarChart.as				MBarChart
Chart.as				AMChart
LineChart.as			MLineChart
PieChart.as				MPieChart

Component.as			CSprite
FPSMeter.as				FPSMonitor
PushButton.as			MButton
RadioButton.as			MRadioButton && CButtonSelector
CheckBox.as				MCheckBox
Style.as				MFormatFactory && MBitmapDataFactory
HBox.as					CHBox (Allow percentage scaling)
VBox.as					CVBox (Allow percentage scaling)
Label.as				MLabel || (TextField && CTextFormat)
TextArea.as				MTextArea
Text.as					MInputText (multiline = true)
InputText.as			MInputText

NumericStepper.as		MNumericStepper (Not allow float values)

ScrollBar.as			MScrollBar
HScrollBar.as			MScrollBar(true)
VScrollBar.as			MScrollBar(false)
ScrollPane.as			MScrollPane
Slider.as				MSlider
HSlider.as				MSlider(true)
VSlider.as				MSlider(false)
UISlider.as				-
HUISlider.as			-
VUISlider.as			-
RangeSlider.as			-
HRangeSlider.as			-
VRangeSlider.as			-

ProgressBar.as			-

ComboBox.as				-
List.as					-
ListItem.as				-

Panel.as				-
Window.as				MWindowManager && MWindow
Accordion.as			-

Calendar.as				-
ColorChooser.as			-

IndicatorLight.as		-
Knob.as					-
RotarySelector.as		-
Meter.as				-
WheelMenu.as			-

MinimalConfigurator.as	-

-                       MCursorManager
-                       MTooltipFactory
-                       MTween
-                       CSignal

----------------------------------------------------------------------------------------------------
About signals (temperate.extra.Signal<TListener>)
----------------------------------------------------------------------------------------------------
	This class will be not used in temperate lib
(May be your are not want to use signals, or want use another signal lib).
It's just for using as separate lib
(Separated repository for one class is overhead)

Features:
- full compile-time type checking for listeners, arguments and arguments count;
- unlimited number of arguments (full type checked, signals without arguments is allowed as well);
- only one class;
- works on c++ target

This is a extremely simple implementation of signals (no bubbling and etc).
It was made simple becouse:
- for more complex cases using native flashplayer9 events
  is better by all criterions (not only performance);
- other haxe libs do more (hsl-1, hsl-pico-1)

Examples of using see at
https://github.com/cser/temperate/tree/develop/test/src/temperate/extra

Practical exapmples of signals using can be find at
https://github.com/cser/temperate/tree/develop/examples