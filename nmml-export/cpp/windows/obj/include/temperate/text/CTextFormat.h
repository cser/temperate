#ifndef INCLUDED_temperate_text_CTextFormat
#define INCLUDED_temperate_text_CTextFormat

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <nme/text/TextFormat.h>
HX_DECLARE_CLASS2(nme,display,DisplayObject)
HX_DECLARE_CLASS2(nme,display,IBitmapDrawable)
HX_DECLARE_CLASS2(nme,display,InteractiveObject)
HX_DECLARE_CLASS2(nme,events,EventDispatcher)
HX_DECLARE_CLASS2(nme,events,IEventDispatcher)
HX_DECLARE_CLASS2(nme,geom,ColorTransform)
HX_DECLARE_CLASS2(nme,text,TextField)
HX_DECLARE_CLASS2(nme,text,TextFormat)
HX_DECLARE_CLASS2(temperate,text,CTextFormat)
namespace temperate{
namespace text{


class CTextFormat_obj : public ::nme::text::TextFormat_obj{
	public:
		typedef ::nme::text::TextFormat_obj super;
		typedef CTextFormat_obj OBJ_;
		CTextFormat_obj();
		Void __construct(::String font,Dynamic size,Dynamic color,Dynamic bold,Dynamic italic,Dynamic underline,::String url,::String target,::String align,Dynamic leftMargin,Dynamic rightMargin,Dynamic indent,Dynamic leading);

	public:
		static hx::ObjectPtr< CTextFormat_obj > __new(::String font,Dynamic size,Dynamic color,Dynamic bold,Dynamic italic,Dynamic underline,::String url,::String target,::String align,Dynamic leftMargin,Dynamic rightMargin,Dynamic indent,Dynamic leading);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~CTextFormat_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("CTextFormat"); }

		bool embedFonts; /* REM */ 
		Dynamic filters; /* REM */ 
		virtual ::temperate::text::CTextFormat setFont( ::String font,Dynamic embedFonts);
		Dynamic setFont_dyn();

		virtual ::temperate::text::CTextFormat setSize( int size);
		Dynamic setSize_dyn();

		virtual ::temperate::text::CTextFormat setColor( int color);
		Dynamic setColor_dyn();

		virtual ::temperate::text::CTextFormat setBold( bool bold);
		Dynamic setBold_dyn();

		virtual ::temperate::text::CTextFormat setItalic( bool italic);
		Dynamic setItalic_dyn();

		virtual ::temperate::text::CTextFormat setUnderline( bool underline);
		Dynamic setUnderline_dyn();

		virtual ::temperate::text::CTextFormat setFilters( Dynamic filters);
		Dynamic setFilters_dyn();

		double alpha; /* REM */ 
		virtual ::temperate::text::CTextFormat setAlpha( double alpha);
		Dynamic setAlpha_dyn();

		::nme::geom::ColorTransform colorTransform; /* REM */ 
		virtual ::temperate::text::CTextFormat setColorTransform( ::nme::geom::ColorTransform colorTransform);
		Dynamic setColorTransform_dyn();

		virtual ::temperate::text::CTextFormat clone( );
		Dynamic clone_dyn();

		virtual Void applyTo( ::nme::text::TextField textField);
		Dynamic applyTo_dyn();

		virtual ::nme::text::TextField newFixed( Dynamic selectable,::String text);
		Dynamic newFixed_dyn();

		virtual ::nme::text::TextField newAutoSized( Dynamic selectable,::String text);
		Dynamic newAutoSized_dyn();

		virtual ::String toHtml( ::String text);
		Dynamic toHtml_dyn();

		static ::temperate::text::CTextFormat _nullFormat; /* REM */ 
		static Void setNullFormat( ::nme::text::TextField tf);
		static Dynamic setNullFormat_dyn();

		static ::String getHtml( ::nme::text::TextFormat format,::String text);
		static Dynamic getHtml_dyn();

		static ::String addToRight( ::String nullableText,::String additon);
		static Dynamic addToRight_dyn();

		static ::String addToLeft( ::String nullableText,::String additon);
		static Dynamic addToLeft_dyn();

};

} // end namespace temperate
} // end namespace text

#endif /* INCLUDED_temperate_text_CTextFormat */ 
