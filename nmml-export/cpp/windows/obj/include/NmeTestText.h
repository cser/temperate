#ifndef INCLUDED_NmeTestText
#define INCLUDED_NmeTestText

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <nme/display/Sprite.h>
HX_DECLARE_CLASS0(NmeTestText)
HX_DECLARE_CLASS2(nme,display,DisplayObject)
HX_DECLARE_CLASS2(nme,display,DisplayObjectContainer)
HX_DECLARE_CLASS2(nme,display,IBitmapDrawable)
HX_DECLARE_CLASS2(nme,display,InteractiveObject)
HX_DECLARE_CLASS2(nme,display,Sprite)
HX_DECLARE_CLASS2(nme,events,EventDispatcher)
HX_DECLARE_CLASS2(nme,events,IEventDispatcher)


class NmeTestText_obj : public ::nme::display::Sprite_obj{
	public:
		typedef ::nme::display::Sprite_obj super;
		typedef NmeTestText_obj OBJ_;
		NmeTestText_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< NmeTestText_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~NmeTestText_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("NmeTestText"); }

		virtual Void init( );
		Dynamic init_dyn();

};


#endif /* INCLUDED_NmeTestText */ 
