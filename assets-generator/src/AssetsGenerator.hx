package ;

import neko.FileSystem;
import neko.io.File;
import neko.io.Path;
import neko.Lib;
import neko.Sys;

class AssetsGenerator 
{
	static function main() 
	{
		var parameters = {
			inputPath: "assets",
			outputPath: "generated",
			packageName: "assets",
			sfwmillPath: "swfmill",
			outputSwfPath: "assets.swf",
			swfmillXmlPath: "swfmill-build.xml",
			assetsPath: "assets"
		};
		{
			// Parameters reading
			
			var args = Sys.args();
			var isParametersCorrect = true;
			if (args.length % 2 == 1)
			{
				Lib.println("Error: expected format: -parameter value");
				isParametersCorrect = false;
			}
			for (i in 0 ... (args.length >> 1))
			{
				var name = args[i << 1];
				var value = args[(i << 1) + 1];
				if (!~/^\-/.match(name))
				{
					Lib.println("Error: incorrect parameter: " + name);
					isParametersCorrect = false;
				}
				else if (Reflect.field(parameters, normalizeParameter(name)) == null)
				{
					Lib.println("Error: unexpected parameter: " + name);
					isParametersCorrect = false;
				}
			}
			if (!isParametersCorrect)
			{
				Lib.println("Default parameters:");
				printParameters(parameters);
				return;
			}
			for (i in 0 ... (args.length >> 1))
			{
				var name = normalizeParameter(args[i << 1]);
				var value = args[(i << 1) + 1];
				Reflect.setField(parameters, name, value);
			}
			Lib.println("Parameters:");
			printParameters(parameters);
		}
		{
			// Clear output
			
			clearDir(parameters.outputPath);
		}
		
		{
			// Assets generation
			var xmlText = '
				<?xml version="1.0" encoding="utf-8"?>
				<!--File was generated.-->
				<!--Any modifications you make may be lost.-->
				<movie version="9" width="800" height="600" framerate="30">
					<background color="#FFFFFF" />
					<frame>
						<library>
				#lines
						</library>
					</frame>
				</movie>
			';
			xmlText = ~/^\s+/.replace(xmlText, "");
			xmlText = ~/\s+$/.replace(xmlText, "");
			xmlText = ~/\r\n/g.replace(xmlText, "\n");
			xmlText = ~/\n\t\t\t\t/g.replace(xmlText, "\n");
			
			var lines = generateForDir(parameters.inputPath, parameters.packageName, parameters.outputPath, parameters.assetsPath);
			xmlText = ~/#lines/g.replace(xmlText, lines.join("\n"));
			
			var file = File.write(parameters.swfmillXmlPath, false);
			file.writeString(xmlText);
			file.close();
		}
		{
			// Run swfmill
			
			Sys.command(
				"\"" + parameters.sfwmillPath + "\" " +
				"simple " + ~/\//g.replace(parameters.swfmillXmlPath, "\\") + " " + parameters.outputSwfPath
			);
		}
	}
	
	static function printParameters(parameters)
	{
		for (name in Reflect.fields(parameters))
		{
			Lib.println("-" + name + " \"" + Reflect.field(parameters, name) + "\"");
		}
	}
	
	static function normalizeParameter(name:String):String
	{
		return ~/^\-+/.replace(name, "");
	}
	
	static function clearDir(dir:String)
	{
		var fileNames = FileSystem.readDirectory(dir);
		for (fileName in fileNames)
		{
			var filePath:String = dir + "/" + fileName;
			if (FileSystem.isDirectory(filePath))
			{
				clearDir(filePath);
				FileSystem.deleteDirectory(filePath);
			}
			else
			{
				FileSystem.deleteFile(filePath);
			}
		}
	}
	
	static function generateForDir(dir:String, packageName:String, outputPath:String, assetsPath:String):Array<String>
	{
		var result = [];
		var fileNames = FileSystem.readDirectory(dir);
		for (fileName in fileNames)
		{
			var filePath = dir + "/" + fileName;
			if (FileSystem.isDirectory(filePath))
			{
				FileSystem.createDirectory(outputPath + "/" + fileName);
				result = result.concat(
					generateForDir(filePath, packageName + "." + fileName, outputPath + "/" + fileName, assetsPath + "/" + fileName)
				);
			}
			else
			{
				var extension = Path.extension(fileName).toLowerCase();
				if (extension == "png" || extension == "jpg" || extension == "jpeg")
				{
					var text = "
						package #packageName;
						import flash.display.BitmapData;
						
						/**
						 * Class was generated.
						 * Any modifications you make may be lost.
						 */
						class #className extends BitmapData
						{
							public function new() 
							{
								super(0, 0);
							}
						}
					";
					text = ~/^\s+/.replace(text, "");
					text = ~/\s+$/.replace(text, "");
					text = ~/\r\n/g.replace(text, "\n");
					text = ~/\n\t\t\t\t\t\t/g.replace(text, "\n");
					
					var className = classConventionName(Path.withoutExtension(fileName));
					text = ~/#packageName/g.replace(text, packageName);
					text = ~/#className/g.replace(text, className);
					
					var file = File.write(outputPath + "/" + className + '.hx', false);
					file.writeString(text);
					file.close();
					
					result.push(
						'\t\t\t<bitmap id="' + packageName + '.' + className + '" \n' +
						'\t\t\t\tname="' + ~/\//g.replace(assetsPath, ".") + "." + fileName + '" \n' +
						'\t\t\t\timport="' + assetsPath + "/" + fileName + '" />'
					);
				}
			}
		}
		return result;
	}
	
	static function classConventionName(name:String):String
	{
		name = ~/([_-]\w)/g.customReplace(name, replaceToUpperCase);
		name = ~/[_-]/g.replace(name, "");
		if (name.length > 0)
		{
			name = name.substr(0, 1).toUpperCase() + name.substr(1);
		}
		return name;
	}

	static function replaceToUpperCase(reg:EReg):String
	{
		return reg.matched(0).toUpperCase();
	}
}