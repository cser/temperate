#include <hxcpp.h>

#ifndef INCLUDED_hxMath
#include <hxMath.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_temperate_core_CMath
#include <temperate/core/CMath.h>
#endif
namespace temperate{
namespace core{

Void CMath_obj::__construct()
{
	return null();
}

CMath_obj::~CMath_obj() { }

Dynamic CMath_obj::__CreateEmpty() { return  new CMath_obj; }
hx::ObjectPtr< CMath_obj > CMath_obj::__new()
{  hx::ObjectPtr< CMath_obj > result = new CMath_obj();
	result->__construct();
	return result;}

Dynamic CMath_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< CMath_obj > result = new CMath_obj();
	result->__construct();
	return result;}

int CMath_obj::INT_MAX_VALUE;

int CMath_obj::INT_MIN_VALUE;

double CMath_obj::min( double x,double y){
	HX_SOURCE_PUSH("CMath_obj::min")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",10)
	return (  (((x < y))) ? double(x) : double(y) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,min,return )

double CMath_obj::max( double x,double y){
	HX_SOURCE_PUSH("CMath_obj::max")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",15)
	return (  (((x > y))) ? double(x) : double(y) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,max,return )

double CMath_obj::min3( double x,double y,double z){
	HX_SOURCE_PUSH("CMath_obj::min3")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",21)
	double min = (  (((x < y))) ? double(x) : double(y) );
	HX_SOURCE_POS("src/temperate/core/CMath.hx",22)
	return (  (((min < z))) ? double(min) : double(z) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(CMath_obj,min3,return )

double CMath_obj::max3( double x,double y,double z){
	HX_SOURCE_PUSH("CMath_obj::max3")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",27)
	double max = (  (((x > y))) ? double(x) : double(y) );
	HX_SOURCE_POS("src/temperate/core/CMath.hx",28)
	return (  (((max > z))) ? double(max) : double(z) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(CMath_obj,max3,return )

int CMath_obj::intMin( int x,int y){
	HX_SOURCE_PUSH("CMath_obj::intMin")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",32)
	return (  (((x < y))) ? int(x) : int(y) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,intMin,return )

int CMath_obj::intMax( int x,int y){
	HX_SOURCE_PUSH("CMath_obj::intMax")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",37)
	return (  (((x > y))) ? int(x) : int(y) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,intMax,return )

int CMath_obj::intMin3( int x,int y,int z){
	HX_SOURCE_PUSH("CMath_obj::intMin3")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",43)
	int min = (  (((x < y))) ? int(x) : int(y) );
	HX_SOURCE_POS("src/temperate/core/CMath.hx",44)
	return (  (((min < z))) ? int(min) : int(z) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(CMath_obj,intMin3,return )

int CMath_obj::intMax3( int x,int y,int z){
	HX_SOURCE_PUSH("CMath_obj::intMax3")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",49)
	int max = (  (((x > y))) ? int(x) : int(y) );
	HX_SOURCE_POS("src/temperate/core/CMath.hx",50)
	return (  (((max > z))) ? int(max) : int(z) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC3(CMath_obj,intMax3,return )

double CMath_obj::abs( double x){
	HX_SOURCE_PUSH("CMath_obj::abs")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",54)
	return (  (((x > (int)0))) ? double(x) : double(-(x)) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(CMath_obj,abs,return )

int CMath_obj::intAbs( int x){
	HX_SOURCE_PUSH("CMath_obj::intAbs")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",59)
	return (  (((x > (int)0))) ? int(x) : int(-(x)) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(CMath_obj,intAbs,return )

double CMath_obj::getAlpha( int color){
	HX_SOURCE_PUSH("CMath_obj::getAlpha")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",64)
	return (double((hx::UShr(color,(int)24))) / double((int)255));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(CMath_obj,getAlpha,return )

int CMath_obj::getColor( int color){
	HX_SOURCE_PUSH("CMath_obj::getColor")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",69)
	return (int(color) & int((int)16777215));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(CMath_obj,getColor,return )

int CMath_obj::applyAlpha( int colorPart,double alphaPart){
	HX_SOURCE_PUSH("CMath_obj::applyAlpha")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",74)
	return (int((int(::Std_obj::_int(((int)255 * alphaPart))) << int((int)24))) | int((int((int)16777215) & int(colorPart))));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,applyAlpha,return )

::String CMath_obj::toFixed( double x,int fractionDigits){
	HX_SOURCE_PUSH("CMath_obj::toFixed")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",83)
	{
		HX_SOURCE_POS("src/temperate/core/CMath.hx",83)
		int _g = (int)0;
		HX_SOURCE_POS("src/temperate/core/CMath.hx",83)
		while(((_g < fractionDigits))){
			HX_SOURCE_POS("src/temperate/core/CMath.hx",83)
			int i = (_g)++;
			HX_SOURCE_POS("src/temperate/core/CMath.hx",85)
			hx::MultEq(x,(int)10);
		}
	}
	HX_SOURCE_POS("src/temperate/core/CMath.hx",87)
	::String text = ::Std_obj::string(::Math_obj::round(x));
	HX_SOURCE_POS("src/temperate/core/CMath.hx",88)
	if (((fractionDigits <= (int)0))){
		HX_SOURCE_POS("src/temperate/core/CMath.hx",89)
		return (  (((text == HX_CSTRING("0")))) ? ::String(HX_CSTRING("0.")) : ::String(text) );
	}
	else{
		HX_SOURCE_POS("src/temperate/core/CMath.hx",94)
		int index = (text.length - fractionDigits);
		HX_SOURCE_POS("src/temperate/core/CMath.hx",95)
		if (((index >= (int)0))){
			HX_SOURCE_POS("src/temperate/core/CMath.hx",97)
			::String left = text.substr((int)0,index);
			HX_SOURCE_POS("src/temperate/core/CMath.hx",98)
			return ((((  (((left != HX_CSTRING("")))) ? ::String(left) : ::String(HX_CSTRING("0")) )) + HX_CSTRING(".")) + text.substr(index,null()));
		}
		else{
			HX_SOURCE_POS("src/temperate/core/CMath.hx",102)
			{
				HX_SOURCE_POS("src/temperate/core/CMath.hx",102)
				int _g1 = (int)0;
				int _g = -(index);
				HX_SOURCE_POS("src/temperate/core/CMath.hx",102)
				while(((_g1 < _g))){
					HX_SOURCE_POS("src/temperate/core/CMath.hx",102)
					int i = (_g1)++;
					HX_SOURCE_POS("src/temperate/core/CMath.hx",104)
					text = (HX_CSTRING("0") + text);
				}
			}
			HX_SOURCE_POS("src/temperate/core/CMath.hx",106)
			return (HX_CSTRING("0.") + text);
		}
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,toFixed,return )

::String CMath_obj::toLimitDigits( double x,int maxDigits){
	HX_SOURCE_PUSH("CMath_obj::toLimitDigits")
	HX_SOURCE_POS("src/temperate/core/CMath.hx",114)
	int k = ::Math_obj::round(::Math_obj::pow((int)10,maxDigits));
	HX_SOURCE_POS("src/temperate/core/CMath.hx",115)
	return ::Std_obj::string((double(::Math_obj::round((x * k))) / double(k)));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,toLimitDigits,return )

::String CMath_obj::toString( double x,Dynamic __o_radix){
int radix = __o_radix.Default(10);
	HX_SOURCE_PUSH("CMath_obj::toString");
{
		HX_SOURCE_POS("src/temperate/core/CMath.hx",119)
		return ::Std_obj::string(x);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CMath_obj,toString,return )


CMath_obj::CMath_obj()
{
}

void CMath_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(CMath);
	HX_MARK_END_CLASS();
}

Dynamic CMath_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"min") ) { return min_dyn(); }
		if (HX_FIELD_EQ(inName,"max") ) { return max_dyn(); }
		if (HX_FIELD_EQ(inName,"abs") ) { return abs_dyn(); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"min3") ) { return min3_dyn(); }
		if (HX_FIELD_EQ(inName,"max3") ) { return max3_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"intMin") ) { return intMin_dyn(); }
		if (HX_FIELD_EQ(inName,"intMax") ) { return intMax_dyn(); }
		if (HX_FIELD_EQ(inName,"intAbs") ) { return intAbs_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"intMin3") ) { return intMin3_dyn(); }
		if (HX_FIELD_EQ(inName,"intMax3") ) { return intMax3_dyn(); }
		if (HX_FIELD_EQ(inName,"toFixed") ) { return toFixed_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"getAlpha") ) { return getAlpha_dyn(); }
		if (HX_FIELD_EQ(inName,"getColor") ) { return getColor_dyn(); }
		if (HX_FIELD_EQ(inName,"toString") ) { return toString_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"applyAlpha") ) { return applyAlpha_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"INT_MAX_VALUE") ) { return INT_MAX_VALUE; }
		if (HX_FIELD_EQ(inName,"INT_MIN_VALUE") ) { return INT_MIN_VALUE; }
		if (HX_FIELD_EQ(inName,"toLimitDigits") ) { return toLimitDigits_dyn(); }
	}
	return super::__Field(inName);
}

Dynamic CMath_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 13:
		if (HX_FIELD_EQ(inName,"INT_MAX_VALUE") ) { INT_MAX_VALUE=inValue.Cast< int >(); return inValue; }
		if (HX_FIELD_EQ(inName,"INT_MIN_VALUE") ) { INT_MIN_VALUE=inValue.Cast< int >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void CMath_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("INT_MAX_VALUE"),
	HX_CSTRING("INT_MIN_VALUE"),
	HX_CSTRING("min"),
	HX_CSTRING("max"),
	HX_CSTRING("min3"),
	HX_CSTRING("max3"),
	HX_CSTRING("intMin"),
	HX_CSTRING("intMax"),
	HX_CSTRING("intMin3"),
	HX_CSTRING("intMax3"),
	HX_CSTRING("abs"),
	HX_CSTRING("intAbs"),
	HX_CSTRING("getAlpha"),
	HX_CSTRING("getColor"),
	HX_CSTRING("applyAlpha"),
	HX_CSTRING("toFixed"),
	HX_CSTRING("toLimitDigits"),
	HX_CSTRING("toString"),
	String(null()) };

static ::String sMemberFields[] = {
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(CMath_obj::INT_MAX_VALUE,"INT_MAX_VALUE");
	HX_MARK_MEMBER_NAME(CMath_obj::INT_MIN_VALUE,"INT_MIN_VALUE");
};

Class CMath_obj::__mClass;

void CMath_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("temperate.core.CMath"), hx::TCanCast< CMath_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void CMath_obj::__boot()
{
	hx::Static(INT_MAX_VALUE) = (int)2147483647;
	hx::Static(INT_MIN_VALUE) = (int)-2147483648;
}

} // end namespace temperate
} // end namespace core
