#ifndef INCLUDED_CppTestMainNmml
#define INCLUDED_CppTestMainNmml

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(CppTestMainNmml)


class CppTestMainNmml_obj : public hx::Object{
	public:
		typedef hx::Object super;
		typedef CppTestMainNmml_obj OBJ_;
		CppTestMainNmml_obj();
		Void __construct();

	public:
		static hx::ObjectPtr< CppTestMainNmml_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~CppTestMainNmml_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		::String __ToString() const { return HX_CSTRING("CppTestMainNmml"); }

		static Void main( );
		static Dynamic main_dyn();

};


#endif /* INCLUDED_CppTestMainNmml */ 
