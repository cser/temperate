class ApplicationMain
{

	#if waxe
	static public var frame : wx.Frame;
	static public var autoShowFrame : Bool = true;
	#if nme
	static public var nmeStage : wx.NMEStage;
	#end
	#end
	
	public static function main()
	{
		nme.Lib.setPackage("NME", "MyApplication", "org.example.myproject", "1.0.0");
		
		
		#if waxe
		wx.App.boot(function()
		{
			
			frame = wx.Frame.create(null, null, "temperate test", null, { width: 640, height: 480 });
			
			#if nme
			var stage = wx.NMEStage.create(frame, null, null, { width: 640, height: 480 });
			#end
			
			CppTestMainNmml.main();
			
			if (autoShowFrame)
			{
				wx.App.setTopWindow(frame);
				frame.shown = true;
			}
		});
		#else
		
		nme.Lib.create(function()
			{ 
				if (640 == 0 && 480 == 0)
				{
					nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
					nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
				}
				
				CppTestMainNmml.main(); 
			},
			640, 480, 
			30, 
			0xffffff,
			(true ? nme.Lib.HARDWARE : 0) |
			(true ? nme.Lib.RESIZABLE : 0) |
			(false ? nme.Lib.BORDERLESS : 0) |
			(false ? nme.Lib.VSYNC : 0) |
			(false ? nme.Lib.FULLSCREEN : 0) |
			(1 == 4 ? nme.Lib.HW_AA_HIRES : 0) |
			(1 == 2 ? nme.Lib.HW_AA : 0),
			"temperate test"
			
		);
		#end
		
	}
	
	
	public static function getAsset(inName:String):Dynamic
	{
		
		return null;
	}
	
	
}