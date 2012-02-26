#ifndef INCLUDED_nme_filters_DropShadowFilter
#define INCLUDED_nme_filters_DropShadowFilter

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <nme/filters/BitmapFilter.h>
HX_DECLARE_CLASS2(nme,filters,BitmapFilter)
HX_DECLARE_CLASS2(nme,filters,DropShadowFilter)
namespace nme{
namespace filters{


class DropShadowFilter_obj : public ::nme::filters::BitmapFilter_obj{
	public:
		typedef ::nme::filters::BitmapFilter_obj super;
		typedef DropShadowFilter_obj OBJ_;
		DropShadowFilter_obj();
		Void __construct(Dynamic __o_in_distance,Dynamic __o_in_angle,Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout,Dynamic __o_in_hideObject);

	public:
		static hx::ObjectPtr< DropShadowFilter_obj > __new(Dynamic __o_in_distance,Dynamic __o_in_angle,Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout,Dynamic __o_in_hideObject);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~DropShadowFilter_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("DropShadowFilter"); }

		double alpha; /* REM */ 
		double angle; /* REM */ 
		double blurX; /* REM */ 
		double blurY; /* REM */ 
		int color; /* REM */ 
		double distance; /* REM */ 
		bool hideObject; /* REM */ 
		bool inner; /* REM */ 
		bool knockout; /* REM */ 
		int quality; /* REM */ 
		double strength; /* REM */ 
		virtual ::nme::filters::BitmapFilter clone( );
		Dynamic clone_dyn();

};

} // end namespace nme
} // end namespace filters

#endif /* INCLUDED_nme_filters_DropShadowFilter */ 
