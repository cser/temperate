#include <hxcpp.h>

#ifndef INCLUDED_nme_filters_BitmapFilter
#include <nme/filters/BitmapFilter.h>
#endif
#ifndef INCLUDED_nme_filters_DropShadowFilter
#include <nme/filters/DropShadowFilter.h>
#endif
#ifndef INCLUDED_nme_filters_GlowFilter
#include <nme/filters/GlowFilter.h>
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
namespace temperate{
namespace minimal{

Void MFormatFactory_obj::__construct()
{
	return null();
}

MFormatFactory_obj::~MFormatFactory_obj() { }

Dynamic MFormatFactory_obj::__CreateEmpty() { return  new MFormatFactory_obj; }
hx::ObjectPtr< MFormatFactory_obj > MFormatFactory_obj::__new()
{  hx::ObjectPtr< MFormatFactory_obj > result = new MFormatFactory_obj();
	result->__construct();
	return result;}

Dynamic MFormatFactory_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< MFormatFactory_obj > result = new MFormatFactory_obj();
	result->__construct();
	return result;}

::String MFormatFactory_obj::DEFAULT_FONT;

::temperate::text::CTextFormat MFormatFactory_obj::BUTTON_BASE;

::temperate::text::CTextFormat MFormatFactory_obj::BUTTON_UP;

::temperate::text::CTextFormat MFormatFactory_obj::BUTTON_OVER;

::temperate::text::CTextFormat MFormatFactory_obj::BUTTON_DISABLED;

::temperate::text::CTextFormat MFormatFactory_obj::FLAT_BUTTON_BASE;

::temperate::text::CTextFormat MFormatFactory_obj::FLAT_BUTTON_UP;

::temperate::text::CTextFormat MFormatFactory_obj::FLAT_BUTTON_OVER;

::temperate::text::CTextFormat MFormatFactory_obj::FLAT_BUTTON_DISABLED;

::temperate::text::CTextFormat MFormatFactory_obj::LABEL_BASE;

::temperate::text::CTextFormat MFormatFactory_obj::LABEL;

::temperate::text::CTextFormat MFormatFactory_obj::LABEL_DISABLED;

::temperate::text::CTextFormat MFormatFactory_obj::LABEL_ERROR;

::temperate::text::CTextFormat MFormatFactory_obj::WINDOW_TITLE;

::temperate::text::CTextFormat MFormatFactory_obj::WINDOW_TITLE_DISABLED;


MFormatFactory_obj::MFormatFactory_obj()
{
}

void MFormatFactory_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(MFormatFactory);
	HX_MARK_END_CLASS();
}

Dynamic MFormatFactory_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"LABEL") ) { return LABEL; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"BUTTON_UP") ) { return BUTTON_UP; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"LABEL_BASE") ) { return LABEL_BASE; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"BUTTON_BASE") ) { return BUTTON_BASE; }
		if (HX_FIELD_EQ(inName,"BUTTON_OVER") ) { return BUTTON_OVER; }
		if (HX_FIELD_EQ(inName,"LABEL_ERROR") ) { return LABEL_ERROR; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"DEFAULT_FONT") ) { return DEFAULT_FONT; }
		if (HX_FIELD_EQ(inName,"WINDOW_TITLE") ) { return WINDOW_TITLE; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_UP") ) { return FLAT_BUTTON_UP; }
		if (HX_FIELD_EQ(inName,"LABEL_DISABLED") ) { return LABEL_DISABLED; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"BUTTON_DISABLED") ) { return BUTTON_DISABLED; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_BASE") ) { return FLAT_BUTTON_BASE; }
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_OVER") ) { return FLAT_BUTTON_OVER; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_DISABLED") ) { return FLAT_BUTTON_DISABLED; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"WINDOW_TITLE_DISABLED") ) { return WINDOW_TITLE_DISABLED; }
	}
	return super::__Field(inName);
}

Dynamic MFormatFactory_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"LABEL") ) { LABEL=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"BUTTON_UP") ) { BUTTON_UP=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"LABEL_BASE") ) { LABEL_BASE=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"BUTTON_BASE") ) { BUTTON_BASE=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		if (HX_FIELD_EQ(inName,"BUTTON_OVER") ) { BUTTON_OVER=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		if (HX_FIELD_EQ(inName,"LABEL_ERROR") ) { LABEL_ERROR=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"DEFAULT_FONT") ) { DEFAULT_FONT=inValue.Cast< ::String >(); return inValue; }
		if (HX_FIELD_EQ(inName,"WINDOW_TITLE") ) { WINDOW_TITLE=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_UP") ) { FLAT_BUTTON_UP=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		if (HX_FIELD_EQ(inName,"LABEL_DISABLED") ) { LABEL_DISABLED=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"BUTTON_DISABLED") ) { BUTTON_DISABLED=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 16:
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_BASE") ) { FLAT_BUTTON_BASE=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_OVER") ) { FLAT_BUTTON_OVER=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"FLAT_BUTTON_DISABLED") ) { FLAT_BUTTON_DISABLED=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"WINDOW_TITLE_DISABLED") ) { WINDOW_TITLE_DISABLED=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void MFormatFactory_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("DEFAULT_FONT"),
	HX_CSTRING("BUTTON_BASE"),
	HX_CSTRING("BUTTON_UP"),
	HX_CSTRING("BUTTON_OVER"),
	HX_CSTRING("BUTTON_DISABLED"),
	HX_CSTRING("FLAT_BUTTON_BASE"),
	HX_CSTRING("FLAT_BUTTON_UP"),
	HX_CSTRING("FLAT_BUTTON_OVER"),
	HX_CSTRING("FLAT_BUTTON_DISABLED"),
	HX_CSTRING("LABEL_BASE"),
	HX_CSTRING("LABEL"),
	HX_CSTRING("LABEL_DISABLED"),
	HX_CSTRING("LABEL_ERROR"),
	HX_CSTRING("WINDOW_TITLE"),
	HX_CSTRING("WINDOW_TITLE_DISABLED"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::DEFAULT_FONT,"DEFAULT_FONT");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::BUTTON_BASE,"BUTTON_BASE");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::BUTTON_UP,"BUTTON_UP");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::BUTTON_OVER,"BUTTON_OVER");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::BUTTON_DISABLED,"BUTTON_DISABLED");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::FLAT_BUTTON_BASE,"FLAT_BUTTON_BASE");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::FLAT_BUTTON_UP,"FLAT_BUTTON_UP");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::FLAT_BUTTON_OVER,"FLAT_BUTTON_OVER");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::FLAT_BUTTON_DISABLED,"FLAT_BUTTON_DISABLED");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::LABEL_BASE,"LABEL_BASE");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::LABEL,"LABEL");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::LABEL_DISABLED,"LABEL_DISABLED");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::LABEL_ERROR,"LABEL_ERROR");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::WINDOW_TITLE,"WINDOW_TITLE");
	HX_MARK_MEMBER_NAME(MFormatFactory_obj::WINDOW_TITLE_DISABLED,"WINDOW_TITLE_DISABLED");
};

Class MFormatFactory_obj::__mClass;

void MFormatFactory_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("temperate.minimal.MFormatFactory"), hx::TCanCast< MFormatFactory_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void MFormatFactory_obj::__boot()
{
	hx::Static(DEFAULT_FONT) = HX_CSTRING("Tahoma");
	hx::Static(BUTTON_BASE) = ::temperate::text::CTextFormat_obj::__new(::temperate::minimal::MFormatFactory_obj::DEFAULT_FONT,(int)12,null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null());
	hx::Static(BUTTON_UP) = ::temperate::minimal::MFormatFactory_obj::BUTTON_BASE->clone()->setColor((int)16777198);
	hx::Static(BUTTON_OVER) = ::temperate::minimal::MFormatFactory_obj::BUTTON_BASE->clone()->setColor((int)16777215);
	hx::Static(BUTTON_DISABLED) = ::temperate::minimal::MFormatFactory_obj::BUTTON_BASE->clone()->setColor((int)3166208)->setAlpha(.5);
	hx::Static(FLAT_BUTTON_BASE) = ::temperate::text::CTextFormat_obj::__new(::temperate::minimal::MFormatFactory_obj::DEFAULT_FONT,(int)12,null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null())->setFilters(Array_obj< ::nme::filters::GlowFilter >::__new().Add(::nme::filters::GlowFilter_obj::__new((int)0,.5,(int)6,(int)4,null(),null(),null(),null())));
	hx::Static(FLAT_BUTTON_UP) = ::temperate::minimal::MFormatFactory_obj::FLAT_BUTTON_BASE->clone()->setColor((int)16777198);
	hx::Static(FLAT_BUTTON_OVER) = ::temperate::minimal::MFormatFactory_obj::FLAT_BUTTON_BASE->clone()->setColor((int)16777215);
	hx::Static(FLAT_BUTTON_DISABLED) = ::temperate::minimal::MFormatFactory_obj::FLAT_BUTTON_BASE->clone()->setColor((int)16777215)->setAlpha(.75);
	hx::Static(LABEL_BASE) = ::temperate::text::CTextFormat_obj::__new(::temperate::minimal::MFormatFactory_obj::DEFAULT_FONT,(int)12,null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null());
	hx::Static(LABEL) = ::temperate::minimal::MFormatFactory_obj::LABEL_BASE->clone();
	hx::Static(LABEL_DISABLED) = ::temperate::minimal::MFormatFactory_obj::LABEL->clone()->setAlpha(.3);
	hx::Static(LABEL_ERROR) = ::temperate::minimal::MFormatFactory_obj::LABEL->clone()->setColor((int)10526720);
	hx::Static(WINDOW_TITLE) = ::temperate::text::CTextFormat_obj::__new(::temperate::minimal::MFormatFactory_obj::DEFAULT_FONT,(int)14,null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null())->setBold(true)->setFilters(Array_obj< ::nme::filters::GlowFilter >::__new().Add(::nme::filters::GlowFilter_obj::__new((int)16777215,.5,(int)4,(int)4,(int)10,null(),null(),null())));
	hx::Static(WINDOW_TITLE_DISABLED) = ::temperate::minimal::MFormatFactory_obj::WINDOW_TITLE->clone()->setAlpha(.7);
}

} // end namespace temperate
} // end namespace minimal
