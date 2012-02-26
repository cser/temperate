#ifndef INCLUDED_temperate_core_CMath
#define INCLUDED_temperate_core_CMath

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(temperate,core,CMath)
namespace temperate{
namespace core{


class CMath_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef CMath_obj OBJ_;
		CMath_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< CMath_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~CMath_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("CMath"); }

		static int INT_MAX_VALUE; /* REM */ 
		static int INT_MIN_VALUE; /* REM */ 
		static double min( double x,double y);
		static Dynamic min_dyn();

		static double max( double x,double y);
		static Dynamic max_dyn();

		static double min3( double x,double y,double z);
		static Dynamic min3_dyn();

		static double max3( double x,double y,double z);
		static Dynamic max3_dyn();

		static int intMin( int x,int y);
		static Dynamic intMin_dyn();

		static int intMax( int x,int y);
		static Dynamic intMax_dyn();

		static int intMin3( int x,int y,int z);
		static Dynamic intMin3_dyn();

		static int intMax3( int x,int y,int z);
		static Dynamic intMax3_dyn();

		static double abs( double x);
		static Dynamic abs_dyn();

		static int intAbs( int x);
		static Dynamic intAbs_dyn();

		static double getAlpha( int color);
		static Dynamic getAlpha_dyn();

		static int getColor( int color);
		static Dynamic getColor_dyn();

		static int applyAlpha( int colorPart,double alphaPart);
		static Dynamic applyAlpha_dyn();

		static ::String toFixed( double x,int fractionDigits);
		static Dynamic toFixed_dyn();

		static ::String toLimitDigits( double x,int maxDigits);
		static Dynamic toLimitDigits_dyn();

		static ::String toString( double x,Dynamic radix);
		static Dynamic toString_dyn();

};

} // end namespace temperate
} // end namespace core

#endif /* INCLUDED_temperate_core_CMath */ 
