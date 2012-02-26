#include <hxcpp.h>

#ifndef INCLUDED_CppTestMainNmml
#include <CppTestMainNmml.h>
#endif
#ifndef INCLUDED_NmeTestText
#include <NmeTestText.h>
#endif
#ifndef INCLUDED_nme_Lib
#include <nme/Lib.h>
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
#ifndef INCLUDED_nme_display_MovieClip
#include <nme/display/MovieClip.h>
#endif
#ifndef INCLUDED_nme_display_Sprite
#include <nme/display/Sprite.h>
#endif
#ifndef INCLUDED_nme_display_Stage
#include <nme/display/Stage.h>
#endif
#ifndef INCLUDED_nme_display_StageAlign
#include <nme/display/StageAlign.h>
#endif
#ifndef INCLUDED_nme_display_StageScaleMode
#include <nme/display/StageScaleMode.h>
#endif
#ifndef INCLUDED_nme_events_EventDispatcher
#include <nme/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_nme_events_IEventDispatcher
#include <nme/events/IEventDispatcher.h>
#endif

Void CppTestMainNmml_obj::__construct()
{
	return null();
}

CppTestMainNmml_obj::~CppTestMainNmml_obj() { }

Dynamic CppTestMainNmml_obj::__CreateEmpty() { return  new CppTestMainNmml_obj; }
hx::ObjectPtr< CppTestMainNmml_obj > CppTestMainNmml_obj::__new()
{  hx::ObjectPtr< CppTestMainNmml_obj > result = new CppTestMainNmml_obj();
	result->__construct();
	return result;}

Dynamic CppTestMainNmml_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< CppTestMainNmml_obj > result = new CppTestMainNmml_obj();
	result->__construct();
	return result;}

Void CppTestMainNmml_obj::main( ){
{
		HX_SOURCE_PUSH("CppTestMainNmml_obj::main")
		HX_SOURCE_POS("manual-tests-src-cpp/CppTestMainNmml.hx",10)
		::nme::display::Stage stage = ::nme::Lib_obj::nmeGetCurrent()->nmeGetStage();
		HX_SOURCE_POS("manual-tests-src-cpp/CppTestMainNmml.hx",11)
		stage->nmeSetAlign(::nme::display::StageAlign_obj::TOP_LEFT_dyn());
		HX_SOURCE_POS("manual-tests-src-cpp/CppTestMainNmml.hx",12)
		stage->nmeSetScaleMode(::nme::display::StageScaleMode_obj::NO_SCALE_dyn());
		HX_SOURCE_POS("manual-tests-src-cpp/CppTestMainNmml.hx",18)
		::NmeTestText test = ::NmeTestText_obj::__new();
		HX_SOURCE_POS("manual-tests-src-cpp/CppTestMainNmml.hx",19)
		::nme::Lib_obj::nmeGetCurrent()->addChild(test);
		HX_SOURCE_POS("manual-tests-src-cpp/CppTestMainNmml.hx",20)
		test->init();
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC0(CppTestMainNmml_obj,main,(void))


CppTestMainNmml_obj::CppTestMainNmml_obj()
{
}

void CppTestMainNmml_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(CppTestMainNmml);
	HX_MARK_END_CLASS();
}

Dynamic CppTestMainNmml_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 4:
		if (HX_FIELD_EQ(inName,"main") ) { return main_dyn(); }
	}
	return super::__Field(inName);
}

Dynamic CppTestMainNmml_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	return super::__SetField(inName,inValue);
}

void CppTestMainNmml_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("main"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class CppTestMainNmml_obj::__mClass;

void CppTestMainNmml_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("CppTestMainNmml"), hx::TCanCast< CppTestMainNmml_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void CppTestMainNmml_obj::__boot()
{
}

