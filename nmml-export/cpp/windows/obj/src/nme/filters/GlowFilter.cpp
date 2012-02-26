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
namespace nme{
namespace filters{

Void GlowFilter_obj::__construct(Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout)
{
int in_color = __o_in_color.Default(0);
double in_alpha = __o_in_alpha.Default(1.0);
double in_blurX = __o_in_blurX.Default(6.0);
double in_blurY = __o_in_blurY.Default(6.0);
double in_strength = __o_in_strength.Default(2.0);
int in_quality = __o_in_quality.Default(1);
bool in_inner = __o_in_inner.Default(false);
bool in_knockout = __o_in_knockout.Default(false);
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/GlowFilter.hx",9)
	super::__construct((int)0,(int)0,in_color,in_alpha,in_blurX,in_blurY,in_strength,in_quality,in_inner,in_knockout,false);
}
;
	return null();
}

GlowFilter_obj::~GlowFilter_obj() { }

Dynamic GlowFilter_obj::__CreateEmpty() { return  new GlowFilter_obj; }
hx::ObjectPtr< GlowFilter_obj > GlowFilter_obj::__new(Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout)
{  hx::ObjectPtr< GlowFilter_obj > result = new GlowFilter_obj();
	result->__construct(__o_in_color,__o_in_alpha,__o_in_blurX,__o_in_blurY,__o_in_strength,__o_in_quality,__o_in_inner,__o_in_knockout);
	return result;}

Dynamic GlowFilter_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< GlowFilter_obj > result = new GlowFilter_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5],inArgs[6],inArgs[7]);
	return result;}


GlowFilter_obj::GlowFilter_obj()
{
}

void GlowFilter_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(GlowFilter);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic GlowFilter_obj::__Field(const ::String &inName)
{
	return super::__Field(inName);
}

Dynamic GlowFilter_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	return super::__SetField(inName,inValue);
}

void GlowFilter_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class GlowFilter_obj::__mClass;

void GlowFilter_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("nme.filters.GlowFilter"), hx::TCanCast< GlowFilter_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void GlowFilter_obj::__boot()
{
}

} // end namespace nme
} // end namespace filters
