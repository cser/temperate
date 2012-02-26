#include <hxcpp.h>

#ifndef INCLUDED_hxMath
#include <hxMath.h>
#endif
#ifndef INCLUDED_Std
#include <Std.h>
#endif
#ifndef INCLUDED_nme_display_DisplayObject
#include <nme/display/DisplayObject.h>
#endif
#ifndef INCLUDED_nme_display_IBitmapDrawable
#include <nme/display/IBitmapDrawable.h>
#endif
#ifndef INCLUDED_nme_display_InteractiveObject
#include <nme/display/InteractiveObject.h>
#endif
#ifndef INCLUDED_nme_events_EventDispatcher
#include <nme/events/EventDispatcher.h>
#endif
#ifndef INCLUDED_nme_events_IEventDispatcher
#include <nme/events/IEventDispatcher.h>
#endif
#ifndef INCLUDED_nme_geom_ColorTransform
#include <nme/geom/ColorTransform.h>
#endif
#ifndef INCLUDED_nme_geom_Transform
#include <nme/geom/Transform.h>
#endif
#ifndef INCLUDED_nme_text_TextField
#include <nme/text/TextField.h>
#endif
#ifndef INCLUDED_nme_text_TextFieldAutoSize
#include <nme/text/TextFieldAutoSize.h>
#endif
#ifndef INCLUDED_nme_text_TextFormat
#include <nme/text/TextFormat.h>
#endif
#ifndef INCLUDED_nme_text_TextFormatAlign
#include <nme/text/TextFormatAlign.h>
#endif
#ifndef INCLUDED_temperate_text_CTextFormat
#include <temperate/text/CTextFormat.h>
#endif
namespace temperate{
namespace text{

Void CTextFormat_obj::__construct(::String font,Dynamic size,Dynamic color,Dynamic bold,Dynamic italic,Dynamic underline,::String url,::String target,::String align,Dynamic leftMargin,Dynamic rightMargin,Dynamic indent,Dynamic leading)
{
{
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",17)
	super::__construct(font,size,color,bold,italic,underline,url,target,align,leftMargin,rightMargin,indent,leading);
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",21)
	this->alpha = ::Math_obj::NaN;
}
;
	return null();
}

CTextFormat_obj::~CTextFormat_obj() { }

Dynamic CTextFormat_obj::__CreateEmpty() { return  new CTextFormat_obj; }
hx::ObjectPtr< CTextFormat_obj > CTextFormat_obj::__new(::String font,Dynamic size,Dynamic color,Dynamic bold,Dynamic italic,Dynamic underline,::String url,::String target,::String align,Dynamic leftMargin,Dynamic rightMargin,Dynamic indent,Dynamic leading)
{  hx::ObjectPtr< CTextFormat_obj > result = new CTextFormat_obj();
	result->__construct(font,size,color,bold,italic,underline,url,target,align,leftMargin,rightMargin,indent,leading);
	return result;}

Dynamic CTextFormat_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< CTextFormat_obj > result = new CTextFormat_obj();
	result->__construct(inArgs[0],inArgs[1],inArgs[2],inArgs[3],inArgs[4],inArgs[5],inArgs[6],inArgs[7],inArgs[8],inArgs[9],inArgs[10],inArgs[11],inArgs[12]);
	return result;}

::temperate::text::CTextFormat CTextFormat_obj::setFont( ::String font,Dynamic __o_embedFonts){
bool embedFonts = __o_embedFonts.Default(false);
	HX_SOURCE_PUSH("CTextFormat_obj::setFont");
{
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",30)
		this->font = font;
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",31)
		this->embedFonts = embedFonts;
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",32)
		return hx::ObjectPtr<OBJ_>(this);
	}
}


HX_DEFINE_DYNAMIC_FUNC2(CTextFormat_obj,setFont,return )

::temperate::text::CTextFormat CTextFormat_obj::setSize( int size){
	HX_SOURCE_PUSH("CTextFormat_obj::setSize")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",37)
	this->size = size;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",38)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setSize,return )

::temperate::text::CTextFormat CTextFormat_obj::setColor( int color){
	HX_SOURCE_PUSH("CTextFormat_obj::setColor")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",43)
	this->color = color;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",44)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setColor,return )

::temperate::text::CTextFormat CTextFormat_obj::setBold( bool bold){
	HX_SOURCE_PUSH("CTextFormat_obj::setBold")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",49)
	this->bold = bold;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",50)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setBold,return )

::temperate::text::CTextFormat CTextFormat_obj::setItalic( bool italic){
	HX_SOURCE_PUSH("CTextFormat_obj::setItalic")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",55)
	this->italic = italic;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",56)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setItalic,return )

::temperate::text::CTextFormat CTextFormat_obj::setUnderline( bool underline){
	HX_SOURCE_PUSH("CTextFormat_obj::setUnderline")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",61)
	this->underline = underline;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",62)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setUnderline,return )

::temperate::text::CTextFormat CTextFormat_obj::setFilters( Dynamic filters){
	HX_SOURCE_PUSH("CTextFormat_obj::setFilters")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",67)
	this->filters = filters;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",68)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setFilters,return )

::temperate::text::CTextFormat CTextFormat_obj::setAlpha( double alpha){
	HX_SOURCE_PUSH("CTextFormat_obj::setAlpha")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",75)
	this->alpha = alpha;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",76)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setAlpha,return )

::temperate::text::CTextFormat CTextFormat_obj::setColorTransform( ::nme::geom::ColorTransform colorTransform){
	HX_SOURCE_PUSH("CTextFormat_obj::setColorTransform")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",83)
	this->colorTransform = colorTransform;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",84)
	return hx::ObjectPtr<OBJ_>(this);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setColorTransform,return )

::temperate::text::CTextFormat CTextFormat_obj::clone( ){
	HX_SOURCE_PUSH("CTextFormat_obj::clone")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",89)
	::temperate::text::CTextFormat format = ::temperate::text::CTextFormat_obj::__new(this->font,this->size,this->color,this->bold,this->italic,this->underline,this->url,this->target,this->align,this->leftMargin,this->rightMargin,this->indent,this->leading);
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",93)
	format->blockIndent = this->blockIndent;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",94)
	format->bullet = this->bullet;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",95)
	format->display = this->display;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",96)
	format->kerning = this->kerning;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",97)
	format->letterSpacing = this->letterSpacing;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",98)
	format->tabStops = this->tabStops;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",100)
	format->embedFonts = this->embedFonts;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",101)
	format->filters = this->filters;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",102)
	format->alpha = this->alpha;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",103)
	format->colorTransform = this->colorTransform;
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",105)
	return format;
}


HX_DEFINE_DYNAMIC_FUNC0(CTextFormat_obj,clone,return )

Void CTextFormat_obj::applyTo( ::nme::text::TextField textField){
{
		HX_SOURCE_PUSH("CTextFormat_obj::applyTo")
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",110)
		textField->setTextFormat(hx::ObjectPtr<OBJ_>(this),null(),null());
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",111)
		textField->nmeSetDefaultTextFormat(hx::ObjectPtr<OBJ_>(this));
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",112)
		textField->nmeSetEmbedFonts(this->embedFonts);
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",113)
		textField->nmeSetFilters(this->filters);
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",114)
		if (((this->colorTransform != null()))){
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",116)
			textField->nmeGetTransform()->nmeSetColorTransform(this->colorTransform);
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",117)
			if ((!(::Math_obj::isNaN(this->alpha)))){
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",118)
				textField->nmeSetAlpha(this->alpha);
			}
		}
		else{
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",123)
			textField->nmeSetAlpha((  ((::Math_obj::isNaN(this->alpha))) ? double((int)1) : double(this->alpha) ));
		}
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,applyTo,(void))

::nme::text::TextField CTextFormat_obj::newFixed( Dynamic __o_selectable,::String text){
bool selectable = __o_selectable.Default(false);
	HX_SOURCE_PUSH("CTextFormat_obj::newFixed");
{
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",130)
		::nme::text::TextField textField = ::nme::text::TextField_obj::__new();
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",131)
		textField->nmeSetSelectable(selectable);
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",132)
		this->applyTo(textField);
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",133)
		if (((text != null()))){
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",134)
			textField->nmeSetText(text);
		}
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",137)
		return textField;
	}
}


HX_DEFINE_DYNAMIC_FUNC2(CTextFormat_obj,newFixed,return )

::nme::text::TextField CTextFormat_obj::newAutoSized( Dynamic __o_selectable,::String text){
bool selectable = __o_selectable.Default(false);
	HX_SOURCE_PUSH("CTextFormat_obj::newAutoSized");
{
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",142)
		::nme::text::TextField textField = ::nme::text::TextField_obj::__new();
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",143)
		textField->nmeSetAutoSize(::nme::text::TextFieldAutoSize_obj::LEFT_dyn());
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",144)
		textField->nmeSetSelectable(selectable);
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",145)
		this->applyTo(textField);
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",146)
		if (((text != null()))){
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",147)
			textField->nmeSetText(text);
		}
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",150)
		return textField;
	}
}


HX_DEFINE_DYNAMIC_FUNC2(CTextFormat_obj,newAutoSized,return )

::String CTextFormat_obj::toHtml( ::String text){
	HX_SOURCE_PUSH("CTextFormat_obj::toHtml")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",154)
	return ::temperate::text::CTextFormat_obj::getHtml(hx::ObjectPtr<OBJ_>(this),text);
}


HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,toHtml,return )

::temperate::text::CTextFormat CTextFormat_obj::_nullFormat;

Void CTextFormat_obj::setNullFormat( ::nme::text::TextField tf){
{
		HX_SOURCE_PUSH("CTextFormat_obj::setNullFormat")
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",162)
		if (((::temperate::text::CTextFormat_obj::_nullFormat == null()))){
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",164)
			::temperate::text::CTextFormat_obj::_nullFormat = ::temperate::text::CTextFormat_obj::__new(null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null(),null());
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",166)
			::temperate::text::CTextFormat_obj::_nullFormat->align = ::nme::text::TextFormatAlign_obj::LEFT;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",167)
			::temperate::text::CTextFormat_obj::_nullFormat->blockIndent = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",168)
			::temperate::text::CTextFormat_obj::_nullFormat->bold = false;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",169)
			::temperate::text::CTextFormat_obj::_nullFormat->bullet = false;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",170)
			::temperate::text::CTextFormat_obj::_nullFormat->color = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",171)
			::temperate::text::CTextFormat_obj::_nullFormat->font = HX_CSTRING("Times New Roman");
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",172)
			::temperate::text::CTextFormat_obj::_nullFormat->indent = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",173)
			::temperate::text::CTextFormat_obj::_nullFormat->italic = false;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",174)
			::temperate::text::CTextFormat_obj::_nullFormat->kerning = false;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",175)
			::temperate::text::CTextFormat_obj::_nullFormat->leading = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",176)
			::temperate::text::CTextFormat_obj::_nullFormat->leftMargin = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",177)
			::temperate::text::CTextFormat_obj::_nullFormat->letterSpacing = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",178)
			::temperate::text::CTextFormat_obj::_nullFormat->rightMargin = (int)0;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",179)
			::temperate::text::CTextFormat_obj::_nullFormat->size = (int)12;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",180)
			::temperate::text::CTextFormat_obj::_nullFormat->tabStops = Array_obj< int >::__new();
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",181)
			::temperate::text::CTextFormat_obj::_nullFormat->target = HX_CSTRING("");
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",182)
			::temperate::text::CTextFormat_obj::_nullFormat->underline = false;
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",183)
			::temperate::text::CTextFormat_obj::_nullFormat->url = HX_CSTRING("");
			HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",184)
			::temperate::text::CTextFormat_obj::_nullFormat->colorTransform = ::nme::geom::ColorTransform_obj::__new(null(),null(),null(),null(),null(),null(),null(),null());
		}
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",186)
		::temperate::text::CTextFormat_obj::_nullFormat->applyTo(tf);
	}
return null();
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(CTextFormat_obj,setNullFormat,(void))

::String CTextFormat_obj::getHtml( ::nme::text::TextFormat format,::String text){
	HX_SOURCE_PUSH("CTextFormat_obj::getHtml")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",191)
	::String fontTagText = null();
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",193)
	if (((format->font != null()))){
		struct _Function_2_1{
			inline static ::String Block( ::nme::text::TextFormat &format,::String &fontTagText){
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",195)
				::String additon = ((HX_CSTRING(" face=\"") + format->font) + HX_CSTRING("\""));
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",195)
				return (  (((fontTagText != null()))) ? ::String((fontTagText + additon)) : ::String(additon) );
			}
		};
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",194)
		fontTagText = _Function_2_1::Block(format,fontTagText);
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",197)
	if (((format->color != null()))){
		struct _Function_2_1{
			inline static ::String Block( ::nme::text::TextFormat &format,::String &fontTagText){
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",199)
				::String additon = ((HX_CSTRING(" color=\"#") + ::Std_obj::string(format->color)) + HX_CSTRING("\""));
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",199)
				return (  (((fontTagText != null()))) ? ::String((fontTagText + additon)) : ::String(additon) );
			}
		};
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",198)
		fontTagText = _Function_2_1::Block(format,fontTagText);
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",202)
	if (((format->size != null()))){
		struct _Function_2_1{
			inline static ::String Block( ::nme::text::TextFormat &format,::String &fontTagText){
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",204)
				::String additon = ((HX_CSTRING(" size=\"") + format->size) + HX_CSTRING("\""));
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",204)
				return (  (((fontTagText != null()))) ? ::String((fontTagText + additon)) : ::String(additon) );
			}
		};
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",203)
		fontTagText = _Function_2_1::Block(format,fontTagText);
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",206)
	if (((format->letterSpacing != null()))){
		struct _Function_2_1{
			inline static ::String Block( ::nme::text::TextFormat &format,::String &fontTagText){
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",208)
				::String additon = ((HX_CSTRING(" letterspacing=\"") + format->letterSpacing) + HX_CSTRING("\""));
				HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",208)
				return (  (((fontTagText != null()))) ? ::String((fontTagText + additon)) : ::String(additon) );
			}
		};
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",207)
		fontTagText = _Function_2_1::Block(format,fontTagText);
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",211)
	if ((format->kerning)){
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",212)
		fontTagText = (  (((fontTagText != null()))) ? ::String((fontTagText + HX_CSTRING(" kerning=\"1\""))) : ::String(HX_CSTRING(" kerning=\"1\"")) );
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",216)
	::String beginTags = null();
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",217)
	::String endTags = null();
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",218)
	if (((fontTagText != null()))){
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",220)
		beginTags = ((HX_CSTRING("<font") + fontTagText) + HX_CSTRING(">"));
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",221)
		endTags = HX_CSTRING("</font>");
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",224)
	if ((format->bold)){
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",226)
		beginTags = (  (((beginTags != null()))) ? ::String((beginTags + HX_CSTRING("<b>"))) : ::String(HX_CSTRING("<b>")) );
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",227)
		endTags = (  (((endTags != null()))) ? ::String((HX_CSTRING("</b>") + endTags)) : ::String(HX_CSTRING("</b>")) );
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",229)
	if ((format->italic)){
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",231)
		beginTags = (  (((beginTags != null()))) ? ::String((beginTags + HX_CSTRING("<i>"))) : ::String(HX_CSTRING("<i>")) );
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",232)
		endTags = (  (((endTags != null()))) ? ::String((HX_CSTRING("</i>") + endTags)) : ::String(HX_CSTRING("</i>")) );
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",234)
	if ((format->underline)){
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",236)
		beginTags = (  (((beginTags != null()))) ? ::String((beginTags + HX_CSTRING("<u>"))) : ::String(HX_CSTRING("<u>")) );
		HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",237)
		endTags = (  (((endTags != null()))) ? ::String((HX_CSTRING("</u>") + endTags)) : ::String(HX_CSTRING("</u>")) );
	}
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",240)
	return (  (((beginTags == null()))) ? ::String(text) : ::String(((beginTags + text) + endTags)) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CTextFormat_obj,getHtml,return )

::String CTextFormat_obj::addToRight( ::String nullableText,::String additon){
	HX_SOURCE_PUSH("CTextFormat_obj::addToRight")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",244)
	return (  (((nullableText != null()))) ? ::String((nullableText + additon)) : ::String(additon) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CTextFormat_obj,addToRight,return )

::String CTextFormat_obj::addToLeft( ::String nullableText,::String additon){
	HX_SOURCE_PUSH("CTextFormat_obj::addToLeft")
	HX_SOURCE_POS("src/temperate/text/CTextFormat.hx",249)
	return (  (((nullableText != null()))) ? ::String((additon + nullableText)) : ::String(additon) );
}


STATIC_HX_DEFINE_DYNAMIC_FUNC2(CTextFormat_obj,addToLeft,return )


CTextFormat_obj::CTextFormat_obj()
{
}

void CTextFormat_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(CTextFormat);
	HX_MARK_MEMBER_NAME(embedFonts,"embedFonts");
	HX_MARK_MEMBER_NAME(filters,"filters");
	HX_MARK_MEMBER_NAME(alpha,"alpha");
	HX_MARK_MEMBER_NAME(colorTransform,"colorTransform");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic CTextFormat_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"alpha") ) { return alpha; }
		if (HX_FIELD_EQ(inName,"clone") ) { return clone_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"toHtml") ) { return toHtml_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"getHtml") ) { return getHtml_dyn(); }
		if (HX_FIELD_EQ(inName,"filters") ) { return filters; }
		if (HX_FIELD_EQ(inName,"setFont") ) { return setFont_dyn(); }
		if (HX_FIELD_EQ(inName,"setSize") ) { return setSize_dyn(); }
		if (HX_FIELD_EQ(inName,"setBold") ) { return setBold_dyn(); }
		if (HX_FIELD_EQ(inName,"applyTo") ) { return applyTo_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"setColor") ) { return setColor_dyn(); }
		if (HX_FIELD_EQ(inName,"setAlpha") ) { return setAlpha_dyn(); }
		if (HX_FIELD_EQ(inName,"newFixed") ) { return newFixed_dyn(); }
		break;
	case 9:
		if (HX_FIELD_EQ(inName,"addToLeft") ) { return addToLeft_dyn(); }
		if (HX_FIELD_EQ(inName,"setItalic") ) { return setItalic_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"addToRight") ) { return addToRight_dyn(); }
		if (HX_FIELD_EQ(inName,"embedFonts") ) { return embedFonts; }
		if (HX_FIELD_EQ(inName,"setFilters") ) { return setFilters_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"_nullFormat") ) { return _nullFormat; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"setUnderline") ) { return setUnderline_dyn(); }
		if (HX_FIELD_EQ(inName,"newAutoSized") ) { return newAutoSized_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"setNullFormat") ) { return setNullFormat_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"colorTransform") ) { return colorTransform; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"setColorTransform") ) { return setColorTransform_dyn(); }
	}
	return super::__Field(inName);
}

Dynamic CTextFormat_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 5:
		if (HX_FIELD_EQ(inName,"alpha") ) { alpha=inValue.Cast< double >(); return inValue; }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"filters") ) { filters=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"embedFonts") ) { embedFonts=inValue.Cast< bool >(); return inValue; }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"_nullFormat") ) { _nullFormat=inValue.Cast< ::temperate::text::CTextFormat >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"colorTransform") ) { colorTransform=inValue.Cast< ::nme::geom::ColorTransform >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void CTextFormat_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("embedFonts"));
	outFields->push(HX_CSTRING("filters"));
	outFields->push(HX_CSTRING("alpha"));
	outFields->push(HX_CSTRING("colorTransform"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("_nullFormat"),
	HX_CSTRING("setNullFormat"),
	HX_CSTRING("getHtml"),
	HX_CSTRING("addToRight"),
	HX_CSTRING("addToLeft"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("embedFonts"),
	HX_CSTRING("filters"),
	HX_CSTRING("setFont"),
	HX_CSTRING("setSize"),
	HX_CSTRING("setColor"),
	HX_CSTRING("setBold"),
	HX_CSTRING("setItalic"),
	HX_CSTRING("setUnderline"),
	HX_CSTRING("setFilters"),
	HX_CSTRING("alpha"),
	HX_CSTRING("setAlpha"),
	HX_CSTRING("colorTransform"),
	HX_CSTRING("setColorTransform"),
	HX_CSTRING("clone"),
	HX_CSTRING("applyTo"),
	HX_CSTRING("newFixed"),
	HX_CSTRING("newAutoSized"),
	HX_CSTRING("toHtml"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(CTextFormat_obj::_nullFormat,"_nullFormat");
};

Class CTextFormat_obj::__mClass;

void CTextFormat_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("temperate.text.CTextFormat"), hx::TCanCast< CTextFormat_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void CTextFormat_obj::__boot()
{
	hx::Static(_nullFormat);
}

} // end namespace temperate
} // end namespace text
