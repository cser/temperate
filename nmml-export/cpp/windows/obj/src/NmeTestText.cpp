#include <hxcpp.h>

#ifndef INCLUDED_NmeTestText
#include <NmeTestText.h>
#endif
#ifndef INCLUDED_nme_display_DisplayObject
#include <nme/display/DisplayObject.h>
#endif
#ifndef INCLUDED_nme_display_DisplayObjectContainer
#include <nme/display/DisplayObjectContainer.h>
#endif
#ifndef INCLUDED_nme_display_IBitmapDrawable
#include <nme/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_nme_display_InteractiveObject
#include <nme/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_nme_display_Sprite
#include <nme/display/Sprite.h>
#endif
#ifndef INCLUDED_nme_events_EventDispatcher
#include <nme/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_nme_events_IEventDispatcher
#include <nme/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_nme_filters_BitmapFilter
#include <nme/filters/BitmapFilter.h>
#endif
#ifndef INCLUDED_nme_filters_DropShadowFilter
#include <nme/filters/DropShadowFilter.h>
#endif
#ifndef INCLUDED_nme_filters_GlowFilter
#include <nme/filters/GlowFilter.h>
#endif
#ifndef INCLUDED_nme_geom_ColorTransform
#include <nme/geom/ColorTransform.h>
#endif
#ifndef INCLUDED_nme_text_TextField
#include <nme/text/TextField.h>
#endif
#ifndef INCLUDED_nme_text_TextFormat
#include <nme/text/TextFormat.h>
#endif
#ifndef INCLUDED_temperate_minimal_MFormatFactory
#include <temperate/minimal/MFormatFactory.h>
#endif
#ifndef INCLUDED_temperate_text_CTextFormat
#include <temperate/text/CTextFormat.h>
#endif

Void NmeTestText_obj::__construct()
{
{
	HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",11)
	super::__construct();
}
;
	return null();
}

NmeTestText_obj::~NmeTestText_obj() { }

Dynamic NmeTestText_obj::__CreateEmpty() { return  new NmeTestText_obj; }
hx::ObjectPtr< NmeTestText_obj > NmeTestText_obj::__new()
{  hx::ObjectPtr< NmeTestText_obj > result = new NmeTestText_obj();
	result->__construct();
	return result;}

Dynamic NmeTestText_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< NmeTestText_obj > result = new NmeTestText_obj();
	result->__construct();
	return result;}

Void NmeTestText_obj::init( ){
{
		HX_SOURCE_PUSH("NmeTestText_obj::init")
		HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",17)
		{
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",18)
			::nme::text::TextField tf = ::temperate::minimal::MFormatFactory_obj::LABEL->newAutoSized(null(),null());
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",19)
			tf->nmeSetText(HX_CSTRING("LABEL-formated text"));
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",20)
			this->addChild(tf);
		}
		HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",23)
		{
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",24)
			::nme::text::TextField tf = ::temperate::text::CTextFormat_obj::__new(HX_CSTRING("Tahoma"),(int)12,(int)16777215,true,null(),null(),null(),null(),null(),null(),null(),null(),null())->setFilters(Array_obj< ::nme::filters::GlowFilter >::__new().Add(::nme::filters::GlowFilter_obj::__new(null(),null(),null(),null(),null(),null(),null(),null())))->newAutoSized(null(),null());
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",26)
			tf->nmeSetText(HX_CSTRING("TextField with CTextFormat"));
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",27)
			tf->nmeSetY((int)50);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",28)
			this->addChild(tf);
		}
		HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",31)
		{
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",32)
			::nme::text::TextField tf = ::temperate::text::CTextFormat_obj::__new(HX_CSTRING("Tahoma"),(int)12,(int)16711808,true,null(),null(),null(),null(),null(),null(),null(),null(),null())->setAlpha(.5)->newAutoSized(null(),null());
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",35)
			tf->nmeSetText(HX_CSTRING("TextField with CTextFormat alpha = .5"));
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",36)
			tf->nmeSetX((int)200);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",37)
			this->addChild(tf);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",39)
			::nme::text::TextField tf1 = ::temperate::text::CTextFormat_obj::__new(HX_CSTRING("Tahoma"),(int)12,(int)16711808,true,null(),null(),null(),null(),null(),null(),null(),null(),null())->setColorTransform(::nme::geom::ColorTransform_obj::__new((int)0,(int)0,(int)2,.4,(int)0,(int)0,(int)0,(int)0))->newAutoSized(null(),null());
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",42)
			tf1->nmeSetText(HX_CSTRING("TextField with CTextFormat no alpha, colorTransform with alpha = .4"));
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",43)
			tf1->nmeSetX((int)200);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",44)
			tf1->nmeSetY((int)20);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",45)
			this->addChild(tf1);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",47)
			::nme::text::TextField tf2 = ::temperate::text::CTextFormat_obj::__new(HX_CSTRING("Tahoma"),(int)12,(int)16711808,true,null(),null(),null(),null(),null(),null(),null(),null(),null())->setAlpha(.5)->setColorTransform(::nme::geom::ColorTransform_obj::__new((int)0,(int)0,(int)2,.4,(int)0,(int)0,(int)0,(int)0))->newAutoSized(null(),null());
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",51)
			tf2->nmeSetText(HX_CSTRING("TextField with CTextFormat alpha = .5, colorTransform with alpha = .4"));
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",52)
			tf2->nmeSetX((int)200);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",53)
			tf2->nmeSetY((int)40);
			HX_SOURCE_POS("manual-tests-src-cpp/NmeTestText.hx",54)
			this->addChild(tf2);
		}
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(NmeTestText_obj,init,(void))


NmeTestText_obj::NmeTestText_obj()
{
}

void NmeTestText_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(NmeTestText);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic NmeTestText_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"init") ) { return init_dyn(); }
	}
	return super::__Field(inName);
}

Dynamic NmeTestText_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	return super::__SetField(inName,inValue);
}

void NmeTestText_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("init"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class NmeTestText_obj::__mClass;

void NmeTestText_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("NmeTestText"), hx::TCanCast< NmeTestText_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void NmeTestText_obj::__boot()
{
}

