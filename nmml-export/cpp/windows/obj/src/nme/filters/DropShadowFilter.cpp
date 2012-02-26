#include <hxcpp.h>

#ifndef INCLUDED_nme_filters_BitmapFilter
#include <nme/filters/BitmapFilter.h>
#endif
#ifndef INCLUDED_nme_filters_DropShadowFilter
#include <nme/filters/DropShadowFilter.h>
#endif
namespace nme{
namespace filters{

Void DropShadowFilter_obj::__construct(Dynamic __o_in_distance,Dynamic __o_in_angle,Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout,Dynamic __o_in_hideObject)
{
double in_distance = __o_in_distance.Default(4.0);
double in_angle = __o_in_angle.Default(45.0);
int in_color = __o_in_color.Default(0);
double in_alpha = __o_in_alpha.Default(1.0);
double in_blurX = __o_in_blurX.Default(4.0);
double in_blurY = __o_in_blurY.Default(4.0);
double in_strength = __o_in_strength.Default(1.0);
int in_quality = __o_in_quality.Default(1);
bool in_inner = __o_in_inner.Default(false);
bool in_knockout = __o_in_knockout.Default(false);
bool in_hideObject = __o_in_hideObject.Default(false);
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",23)
	super::__construct(HX_CSTRING("DropShadowFilter"));
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",25)
	this->distance = in_distance;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",26)
	this->angle = in_angle;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",27)
	this->color = in_color;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",28)
	this->alpha = in_alpha;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",29)
	this->blurX = in_blurX;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",30)
	this->blurY = in_blurY;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",31)
	this->strength = in_strength;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",32)
	this->quality = in_quality;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",33)
	this->inner = in_inner;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",34)
	this->knockout = in_knockout;
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",35)
	this->hideObject = in_hideObject;
}
;
	return null();
}

DropShadowFilter_obj::~DropShadowFilter_obj() { }

Dynamic DropShadowFilter_obj::__CreateEmpty() { return  new DropShadowFilter_obj; }
hx::ObjectPtr< DropShadowFilter_obj > DropShadowFilter_obj::__new(Dynamic __o_in_distance,Dynamic __o_in_angle,Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout,Dynamic __o_in_hideObject)
{  hx::ObjectPtr< DropShadowFilter_obj > result = new DropShadowFilter_obj();
	result->__construct(__o_in_distance,__o_in_angle,__o_in_color,__o_in_alpha,__o_in_blurX,__o_in_blurY,__o_in_strength,__o_in_quality,__o_in_inner,__o_in_knockout,__o_in_hideObject);
	return result;}

Dynamic DropShadowFilter_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< DropShadowFilter_obj > result = new DropShadowFilter_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5],inArgs[6],inArgs[7],inArgs[8],inArgs[9],inArgs[10]);
	return result;}

::nme::filters::BitmapFilter DropShadowFilter_obj::clone( ){
	HX_SOURCE_PUSH("DropShadowFilter_obj::clone")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\nme/3,2,0/nme/filters/DropShadowFilter.hx",40)
	return ::nme::filters::DropShadowFilter_obj::__new(this->distance,this->angle,this->color,this->alpha,this->blurX,this->blurY,this->strength,this->quality,this->inner,this->knockout,this->hideObject);
}


HX_DEFINE_DYNAMIC_FUNC0(DropShadowFilter_obj,clone,return )


DropShadowFilter_obj::DropShadowFilter_obj()
{
}

void DropShadowFilter_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(DropShadowFilter);
	HX_MARK_MEMBER_NAME(alpha,"alpha");
	HX_MARK_MEMBER_NAME(angle,"angle");
	HX_MARK_MEMBER_NAME(blurX,"blurX");
	HX_MARK_MEMBER_NAME(blurY,"blurY");
	HX_MARK_MEMBER_NAME(color,"color");
	HX_MARK_MEMBER_NAME(distance,"distance");
	HX_MARK_MEMBER_NAME(hideObject,"hideObject");
	HX_MARK_MEMBER_NAME(inner,"inner");
	HX_MARK_MEMBER_NAME(knockout,"knockout");
	HX_MARK_MEMBER_NAME(quality,"quality");
	HX_MARK_MEMBER_NAME(strength,"strength");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic DropShadowFilter_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"alpha") ) { return alpha; }
		if (HX_FIELD_EQ(inName,"angle") ) { return angle; }
		if (HX_FIELD_EQ(inName,"blurX") ) { return blurX; }
		if (HX_FIELD_EQ(inName,"blurY") ) { return blurY; }
		if (HX_FIELD_EQ(inName,"color") ) { return color; }
		if (HX_FIELD_EQ(inName,"inner") ) { return inner; }
		if (HX_FIELD_EQ(inName,"clone") ) { return clone_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"quality") ) { return quality; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"distance") ) { return distance; }
		if (HX_FIELD_EQ(inName,"knockout") ) { return knockout; }
		if (HX_FIELD_EQ(inName,"strength") ) { return strength; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"hideObject") ) { return hideObject; }
	}
	return super::__Field(inName);
}

Dynamic DropShadowFilter_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"alpha") ) { alpha=inValue.Cast< double >(); return inValue; }
		if (HX_FIELD_EQ(inName,"angle") ) { angle=inValue.Cast< double >(); return inValue; }
		if (HX_FIELD_EQ(inName,"blurX") ) { blurX=inValue.Cast< double >(); return inValue; }
		if (HX_FIELD_EQ(inName,"blurY") ) { blurY=inValue.Cast< double >(); return inValue; }
		if (HX_FIELD_EQ(inName,"color") ) { color=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"inner") ) { inner=inValue.Cast< bool >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"quality") ) { quality=inValue.Cast< int >(); return inValue; }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"distance") ) { distance=inValue.Cast< double >(); return inValue; }
		if (HX_FIELD_EQ(inName,"knockout") ) { knockout=inValue.Cast< bool >(); return inValue; }
		if (HX_FIELD_EQ(inName,"strength") ) { strength=inValue.Cast< double >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"hideObject") ) { hideObject=inValue.Cast< bool >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void DropShadowFilter_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("alpha"));
	outFields->push(HX_CSTRING("angle"));
	outFields->push(HX_CSTRING("blurX"));
	outFields->push(HX_CSTRING("blurY"));
	outFields->push(HX_CSTRING("color"));
	outFields->push(HX_CSTRING("distance"));
	outFields->push(HX_CSTRING("hideObject"));
	outFields->push(HX_CSTRING("inner"));
	outFields->push(HX_CSTRING("knockout"));
	outFields->push(HX_CSTRING("quality"));
	outFields->push(HX_CSTRING("strength"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("alpha"),
	HX_CSTRING("angle"),
	HX_CSTRING("blurX"),
	HX_CSTRING("blurY"),
	HX_CSTRING("color"),
	HX_CSTRING("distance"),
	HX_CSTRING("hideObject"),
	HX_CSTRING("inner"),
	HX_CSTRING("knockout"),
	HX_CSTRING("quality"),
	HX_CSTRING("strength"),
	HX_CSTRING("clone"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
};

Class DropShadowFilter_obj::__mClass;

void DropShadowFilter_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("nme.filters.DropShadowFilter"), hx::TCanCast< DropShadowFilter_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void DropShadowFilter_obj::__boot()
{
}

} // end namespace nme
} // end namespace filters
