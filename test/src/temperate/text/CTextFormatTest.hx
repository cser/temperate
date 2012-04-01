package temperate.text;

import flash.text.TextFormat;
import massive.munit.Assert;

class CTextFormatTest
{
	public function new()
	{
	}
	
	@Test
	public function toHtmlTest()
	{
		for (format in [new TextFormat(), new CTextFormat()])
		{
			Assert.areEqual("simple text", CTextFormat.getHtml(format, "simple text"));
			
			format.font = "Arial";
			Assert.areEqual(
				"<font face=\"Arial\">text</font>", CTextFormat.getHtml(format, "text"));
				
			format.font = null;
			format.color = 0xff0000;
			Assert.areEqual(
				"<font color=\"#ff0000\">text</font>", CTextFormat.getHtml(format, "text"));
				
			format.font = null;
			format.color = null;
			format.size = 16;
			Assert.areEqual(
				"<font size=\"16\">text</font>", CTextFormat.getHtml(format, "text"));
				
			format.font = "Lucida";
			format.color = 0xeeeeee;
			format.size = 14;
			Assert.areEqual(
				"<font face=\"Lucida\" color=\"#eeeeee\" size=\"14\">text</font>",
				CTextFormat.getHtml(format, "text"));
		}
		
		for (format in [new TextFormat(), new CTextFormat()])
		{
			format.bold = true;
			Assert.areEqual("<b>text</b>", CTextFormat.getHtml(format, "text"));
			
			format.bold = false;
			Assert.areEqual("text", CTextFormat.getHtml(format, "text"));
			
			format.bold = true;
			format.size = 16;
			Assert.areEqual(
				"<font size=\"16\"><b>text</b></font>", CTextFormat.getHtml(format, "text"));
			
			format.bold = null;
			format.size = null;
				
			format.italic = true;
			Assert.areEqual("<i>text</i>", CTextFormat.getHtml(format, "text"));
			
			format.italic = false;
			Assert.areEqual("text", CTextFormat.getHtml(format, "text"));
			
			format.bold = null;
			format.size = null;
			format.italic = null;
				
			format.underline = true;
			Assert.areEqual("<u>text</u>", CTextFormat.getHtml(format, "text"));
			
			format.underline = false;
			Assert.areEqual("text", CTextFormat.getHtml(format, "text"));
			
			format.bold = null;
			format.size = null;
			format.italic = null;
			format.underline = null;
			
			format.bold = true;
			format.italic = true;
			format.underline = true;
			Assert.areEqual("<b><i><u>text</u></i></b>", CTextFormat.getHtml(format, "text"));
		}
		
		for (format in [new TextFormat(), new CTextFormat()])
		{
			format.letterSpacing = 2;
			format.kerning = true;
			Assert.areEqual(
				"<font letterspacing=\"2\" kerning=\"1\">text</font>",
				CTextFormat.getHtml(format, "text"));
				
			format.letterSpacing = 3;
			format.kerning = false;
			Assert.areEqual(
				"<font letterspacing=\"3\">text</font>", CTextFormat.getHtml(format, "text"));
			
			format.letterSpacing = 2;
			format.kerning = null;
			format.size = 14;
			Assert.areEqual(
				"<font size=\"14\" letterspacing=\"2\">text</font>",
				CTextFormat.getHtml(format, "text"));
		}
	}
}