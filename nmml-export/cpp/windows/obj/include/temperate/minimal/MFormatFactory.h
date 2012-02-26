#ifndef INCLUDED_temperate_minimal_MFormatFactory
#define INCLUDED_temperate_minimal_MFormatFactory

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(nme,text,TextFormat)
HX_DECLARE_CLASS2(temperate,minimal,MFormatFactory)
HX_DECLARE_CLASS2(temperate,text,CTextFormat)
namespace temperate{
namespace minimal{


class MFormatFactory_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef MFormatFactory_obj OBJ_;
		MFormatFactory_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< MFormatFactory_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~MFormatFactory_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("MFormatFactory"); }

		static ::String DEFAULT_FONT; /* REM */ 
		static ::temperate::text::CTextFormat BUTTON_BASE; /* REM */ 
		static ::temperate::text::CTextFormat BUTTON_UP; /* REM */ 
		static ::temperate::text::CTextFormat BUTTON_OVER; /* REM */ 
		static ::temperate::text::CTextFormat BUTTON_DISABLED; /* REM */ 
		static ::temperate::text::CTextFormat FLAT_BUTTON_BASE; /* REM */ 
		static ::temperate::text::CTextFormat FLAT_BUTTON_UP; /* REM */ 
		static ::temperate::text::CTextFormat FLAT_BUTTON_OVER; /* REM */ 
		static ::temperate::text::CTextFormat FLAT_BUTTON_DISABLED; /* REM */ 
		static ::temperate::text::CTextFormat LABEL_BASE; /* REM */ 
		static ::temperate::text::CTextFormat LABEL; /* REM */ 
		static ::temperate::text::CTextFormat LABEL_DISABLED; /* REM */ 
		static ::temperate::text::CTextFormat LABEL_ERROR; /* REM */ 
		static ::temperate::text::CTextFormat WINDOW_TITLE; /* REM */ 
		static ::temperate::text::CTextFormat WINDOW_TITLE_DISABLED; /* REM */ 
};

} // end namespace temperate
} // end namespace minimal

#endif /* INCLUDED_temperate_minimal_MFormatFactory */ 
