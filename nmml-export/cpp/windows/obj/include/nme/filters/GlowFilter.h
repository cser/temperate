#ifndef INCLUDED_nme_filters_GlowFilter
#define INCLUDED_nme_filters_GlowFilter

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <nme/filters/DropShadowFilter.h>
HX_DECLARE_CLASS2(nme,filters,BitmapFilter)
HX_DECLARE_CLASS2(nme,filters,DropShadowFilter)
HX_DECLARE_CLASS2(nme,filters,GlowFilter)
namespace nme{
namespace filters{


class GlowFilter_obj : public ::nme::filters::DropShadowFilter_obj{
	public:
		typedef ::nme::filters::DropShadowFilter_obj super;
		typedef GlowFilter_obj OBJ_;
		GlowFilter_obj();
		Void __construct(Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout);

	public:
		static hx::ObjectPtr< GlowFilter_obj > __new(Dynamic __o_in_color,Dynamic __o_in_alpha,Dynamic __o_in_blurX,Dynamic __o_in_blurY,Dynamic __o_in_strength,Dynamic __o_in_quality,Dynamic __o_in_inner,Dynamic __o_in_knockout);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~GlowFilter_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("GlowFilter"); }

};

} // end namespace nme
} // end namespace filters

#endif /* INCLUDED_nme_filters_GlowFilter */ 
