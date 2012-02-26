#include <hxcpp.h>

#include <cpp/io/_Process/Stdout.h>
#include <cpp/io/_Process/Stdin.h>
#include <nme/display/JointStyle.h>
#include <StringTools.h>
#include <nme/geom/Matrix.h>
#include <Date.h>
#include <nme/errors/EOFError.h>
#include <nme/display/GradientType.h>
#include <nme/display/TriangleCulling.h>
#include <nme/media/SoundTransform.h>
#include <haxe/io/Error.h>
#include <nme/geom/Rectangle.h>
#include <ApplicationMain.h>
#include <nme/Lib.h>
#include <nme/events/KeyboardEvent.h>
#include <cpp/rtti/FieldNumericIntegerLookup.h>
#include <nme/events/ProgressEvent.h>
#include <nme/text/TextFormatAlign.h>
#include <nme/geom/Point.h>
#include <Std.h>
#include <nme/display/StageScaleMode.h>
#include <temperate/core/CMath.h>
#include <nme/display/LineScaleMode.h>
#include <Hash.h>
#include <nme/net/URLLoaderDataFormat.h>
#include <nme/net/URLVariables.h>
#include <haxe/Log.h>
#include <cpp/io/File.h>
#include <cpp/io/FileSeek.h>
#include <nme/events/Listener.h>
#include <nme/utils/ByteArray.h>
#include <haxe/io/Bytes.h>
#include <nme/events/EventPhase.h>
#include <nme/utils/WeakRef.h>
#include <nme/net/URLRequestMethod.h>
#include <nme/events/IOErrorEvent.h>
#include <temperate/minimal/MFormatFactory.h>
#include <nme/filters/GlowFilter.h>
#include <nme/display/BitmapData.h>
#include <nme/events/ErrorEvent.h>
#include <nme/events/TextEvent.h>
#include <nme/filters/DropShadowFilter.h>
#include <cpp/zip/Compress.h>
#include <nme/net/URLRequest.h>
#include <StringBuf.h>
#include <nme/text/TextFieldType.h>
#include <nme/geom/Transform.h>
#include <nme/display/StageAlign.h>
#include <nme/display/ManagedStage.h>
#include <cpp/zip/Flush.h>
#include <CppTestMainNmml.h>
#include <IntHash.h>
#include <haxe/Timer.h>
#include <nme/utils/Endian.h>
#include <nme/geom/ColorTransform.h>
#include <nme/errors/RangeError.h>
#include <nme/errors/Error.h>
#include <nme/filters/BitmapFilter.h>
#include <Type.h>
#include <ValueType.h>
#include <cpp/io/FileOutput.h>
#include <haxe/io/Output.h>
#include <IntIter.h>
#include <nme/display/IGraphicsData.h>
#include <nme/display/SpreadMethod.h>
#include <nme/display/Tilesheet.h>
#include <nme/display/StageDisplayState.h>
#include <Reflect.h>
#include <nme/events/JoystickEvent.h>
#include <cpp/zip/Uncompress.h>
#include <haxe/io/Eof.h>
#include <nme/media/SoundChannel.h>
#include <nme/text/TextField.h>
#include <nme/display/TouchInfo.h>
#include <nme/display/Stage.h>
#include <nme/events/TouchEvent.h>
#include <nme/events/MouseEvent.h>
#include <nme/display/Graphics.h>
#include <nme/net/URLLoader.h>
#include <nme/text/AntiAliasType.h>
#include <temperate/text/CTextFormat.h>
#include <nme/text/TextFormat.h>
#include <nme/utils/IDataInput.h>
#include <nme/events/FocusEvent.h>
#include <nme/events/Event.h>
#include <nme/display/MovieClip.h>
#include <nme/display/StageQuality.h>
#include <nme/display/InterpolationMethod.h>
#include <cpp/Sys.h>
#include <cpp/io/FileInput.h>
#include <haxe/io/Input.h>
#include <List.h>
#include <cpp/FileSystem.h>
#include <cpp/FileKind.h>
#include <nme/display/BlendMode.h>
#include <nme/display/CapsStyle.h>
#include <NmeTestText.h>
#include <nme/display/Sprite.h>
#include <nme/display/DisplayObjectContainer.h>
#include <nme/display/InteractiveObject.h>
#include <nme/display/DisplayObject.h>
#include <cpp/io/Process.h>
#include <cpp/Lib.h>
#include <nme/Loader.h>
#include <nme/events/EventDispatcher.h>
#include <nme/events/IEventDispatcher.h>
#include <nme/text/TextFieldAutoSize.h>
#include <nme/display/IBitmapDrawable.h>
#include <haxe/io/BytesBuffer.h>

void __boot_all()
{
hx::RegisterResources( hx::GetResources() );
::cpp::io::_Process::Stdout_obj::__register();
::cpp::io::_Process::Stdin_obj::__register();
::nme::display::JointStyle_obj::__register();
::StringTools_obj::__register();
::nme::geom::Matrix_obj::__register();
::Date_obj::__register();
::nme::errors::EOFError_obj::__register();
::nme::display::GradientType_obj::__register();
::nme::display::TriangleCulling_obj::__register();
::nme::media::SoundTransform_obj::__register();
::haxe::io::Error_obj::__register();
::nme::geom::Rectangle_obj::__register();
::ApplicationMain_obj::__register();
::nme::Lib_obj::__register();
::nme::events::KeyboardEvent_obj::__register();
::cpp::rtti::FieldNumericIntegerLookup_obj::__register();
::nme::events::ProgressEvent_obj::__register();
::nme::text::TextFormatAlign_obj::__register();
::nme::geom::Point_obj::__register();
::Std_obj::__register();
::nme::display::StageScaleMode_obj::__register();
::temperate::core::CMath_obj::__register();
::nme::display::LineScaleMode_obj::__register();
::Hash_obj::__register();
::nme::net::URLLoaderDataFormat_obj::__register();
::nme::net::URLVariables_obj::__register();
::haxe::Log_obj::__register();
::cpp::io::File_obj::__register();
::cpp::io::FileSeek_obj::__register();
::nme::events::Listener_obj::__register();
::nme::utils::ByteArray_obj::__register();
::haxe::io::Bytes_obj::__register();
::nme::events::EventPhase_obj::__register();
::nme::utils::WeakRef_obj::__register();
::nme::net::URLRequestMethod_obj::__register();
::nme::events::IOErrorEvent_obj::__register();
::temperate::minimal::MFormatFactory_obj::__register();
::nme::filters::GlowFilter_obj::__register();
::nme::display::BitmapData_obj::__register();
::nme::events::ErrorEvent_obj::__register();
::nme::events::TextEvent_obj::__register();
::nme::filters::DropShadowFilter_obj::__register();
::cpp::zip::Compress_obj::__register();
::nme::net::URLRequest_obj::__register();
::StringBuf_obj::__register();
::nme::text::TextFieldType_obj::__register();
::nme::geom::Transform_obj::__register();
::nme::display::StageAlign_obj::__register();
::nme::display::ManagedStage_obj::__register();
::cpp::zip::Flush_obj::__register();
::CppTestMainNmml_obj::__register();
::IntHash_obj::__register();
::haxe::Timer_obj::__register();
::nme::utils::Endian_obj::__register();
::nme::geom::ColorTransform_obj::__register();
::nme::errors::RangeError_obj::__register();
::nme::errors::Error_obj::__register();
::nme::filters::BitmapFilter_obj::__register();
::Type_obj::__register();
::ValueType_obj::__register();
::cpp::io::FileOutput_obj::__register();
::haxe::io::Output_obj::__register();
::IntIter_obj::__register();
::nme::display::IGraphicsData_obj::__register();
::nme::display::SpreadMethod_obj::__register();
::nme::display::Tilesheet_obj::__register();
::nme::display::StageDisplayState_obj::__register();
::Reflect_obj::__register();
::nme::events::JoystickEvent_obj::__register();
::cpp::zip::Uncompress_obj::__register();
::haxe::io::Eof_obj::__register();
::nme::media::SoundChannel_obj::__register();
::nme::text::TextField_obj::__register();
::nme::display::TouchInfo_obj::__register();
::nme::display::Stage_obj::__register();
::nme::events::TouchEvent_obj::__register();
::nme::events::MouseEvent_obj::__register();
::nme::display::Graphics_obj::__register();
::nme::net::URLLoader_obj::__register();
::nme::text::AntiAliasType_obj::__register();
::temperate::text::CTextFormat_obj::__register();
::nme::text::TextFormat_obj::__register();
::nme::utils::IDataInput_obj::__register();
::nme::events::FocusEvent_obj::__register();
::nme::events::Event_obj::__register();
::nme::display::MovieClip_obj::__register();
::nme::display::StageQuality_obj::__register();
::nme::display::InterpolationMethod_obj::__register();
::cpp::Sys_obj::__register();
::cpp::io::FileInput_obj::__register();
::haxe::io::Input_obj::__register();
::List_obj::__register();
::cpp::FileSystem_obj::__register();
::cpp::FileKind_obj::__register();
::nme::display::BlendMode_obj::__register();
::nme::display::CapsStyle_obj::__register();
::NmeTestText_obj::__register();
::nme::display::Sprite_obj::__register();
::nme::display::DisplayObjectContainer_obj::__register();
::nme::display::InteractiveObject_obj::__register();
::nme::display::DisplayObject_obj::__register();
::cpp::io::Process_obj::__register();
::cpp::Lib_obj::__register();
::nme::Loader_obj::__register();
::nme::events::EventDispatcher_obj::__register();
::nme::events::IEventDispatcher_obj::__register();
::nme::text::TextFieldAutoSize_obj::__register();
::nme::display::IBitmapDrawable_obj::__register();
::haxe::io::BytesBuffer_obj::__register();
::nme::utils::ByteArray_obj::__init__();
::cpp::Lib_obj::__boot();
::cpp::io::Process_obj::__boot();
::cpp::FileKind_obj::__boot();
::cpp::FileSystem_obj::__boot();
::cpp::io::FileInput_obj::__boot();
::cpp::Sys_obj::__boot();
::cpp::zip::Uncompress_obj::__boot();
::cpp::io::FileOutput_obj::__boot();
::cpp::zip::Flush_obj::__boot();
::cpp::zip::Compress_obj::__boot();
::cpp::io::FileSeek_obj::__boot();
::cpp::io::File_obj::__boot();
::haxe::Log_obj::__boot();
::cpp::rtti::FieldNumericIntegerLookup_obj::__boot();
::cpp::io::_Process::Stdin_obj::__boot();
::cpp::io::_Process::Stdout_obj::__boot();
::haxe::io::BytesBuffer_obj::__boot();
::nme::display::IBitmapDrawable_obj::__boot();
::nme::text::TextFieldAutoSize_obj::__boot();
::nme::events::IEventDispatcher_obj::__boot();
::nme::events::EventDispatcher_obj::__boot();
::nme::Loader_obj::__boot();
::nme::display::DisplayObject_obj::__boot();
::nme::display::InteractiveObject_obj::__boot();
::nme::display::DisplayObjectContainer_obj::__boot();
::nme::display::Sprite_obj::__boot();
::NmeTestText_obj::__boot();
::nme::display::CapsStyle_obj::__boot();
::nme::display::BlendMode_obj::__boot();
::List_obj::__boot();
::haxe::io::Input_obj::__boot();
::nme::display::InterpolationMethod_obj::__boot();
::nme::display::StageQuality_obj::__boot();
::nme::display::MovieClip_obj::__boot();
::nme::events::Event_obj::__boot();
::nme::events::FocusEvent_obj::__boot();
::nme::utils::IDataInput_obj::__boot();
::nme::text::TextFormat_obj::__boot();
::temperate::text::CTextFormat_obj::__boot();
::nme::text::AntiAliasType_obj::__boot();
::nme::net::URLLoader_obj::__boot();
::nme::display::Graphics_obj::__boot();
::nme::events::MouseEvent_obj::__boot();
::nme::events::TouchEvent_obj::__boot();
::nme::display::Stage_obj::__boot();
::nme::display::TouchInfo_obj::__boot();
::nme::text::TextField_obj::__boot();
::nme::media::SoundChannel_obj::__boot();
::haxe::io::Eof_obj::__boot();
::nme::events::JoystickEvent_obj::__boot();
::Reflect_obj::__boot();
::nme::display::StageDisplayState_obj::__boot();
::nme::display::Tilesheet_obj::__boot();
::nme::display::SpreadMethod_obj::__boot();
::nme::display::IGraphicsData_obj::__boot();
::IntIter_obj::__boot();
::haxe::io::Output_obj::__boot();
::ValueType_obj::__boot();
::Type_obj::__boot();
::nme::filters::BitmapFilter_obj::__boot();
::nme::errors::Error_obj::__boot();
::nme::errors::RangeError_obj::__boot();
::nme::geom::ColorTransform_obj::__boot();
::nme::utils::Endian_obj::__boot();
::haxe::Timer_obj::__boot();
::IntHash_obj::__boot();
::CppTestMainNmml_obj::__boot();
::nme::display::ManagedStage_obj::__boot();
::nme::display::StageAlign_obj::__boot();
::nme::geom::Transform_obj::__boot();
::nme::text::TextFieldType_obj::__boot();
::StringBuf_obj::__boot();
::nme::net::URLRequest_obj::__boot();
::nme::filters::DropShadowFilter_obj::__boot();
::nme::events::TextEvent_obj::__boot();
::nme::events::ErrorEvent_obj::__boot();
::nme::display::BitmapData_obj::__boot();
::nme::filters::GlowFilter_obj::__boot();
::temperate::minimal::MFormatFactory_obj::__boot();
::nme::events::IOErrorEvent_obj::__boot();
::nme::net::URLRequestMethod_obj::__boot();
::nme::utils::WeakRef_obj::__boot();
::nme::events::EventPhase_obj::__boot();
::haxe::io::Bytes_obj::__boot();
::nme::utils::ByteArray_obj::__boot();
::nme::events::Listener_obj::__boot();
::nme::net::URLVariables_obj::__boot();
::nme::net::URLLoaderDataFormat_obj::__boot();
::Hash_obj::__boot();
::nme::display::LineScaleMode_obj::__boot();
::temperate::core::CMath_obj::__boot();
::nme::display::StageScaleMode_obj::__boot();
::Std_obj::__boot();
::nme::geom::Point_obj::__boot();
::nme::text::TextFormatAlign_obj::__boot();
::nme::events::ProgressEvent_obj::__boot();
::nme::events::KeyboardEvent_obj::__boot();
::nme::Lib_obj::__boot();
::ApplicationMain_obj::__boot();
::nme::geom::Rectangle_obj::__boot();
::haxe::io::Error_obj::__boot();
::nme::media::SoundTransform_obj::__boot();
::nme::display::TriangleCulling_obj::__boot();
::nme::display::GradientType_obj::__boot();
::nme::errors::EOFError_obj::__boot();
::Date_obj::__boot();
::nme::geom::Matrix_obj::__boot();
::StringTools_obj::__boot();
::nme::display::JointStyle_obj::__boot();
}

