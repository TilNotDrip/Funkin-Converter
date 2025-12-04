package funkin.converter.modding;

import funkin.converter.utils.System;
import haxe.io.Path;
import polymod.Polymod;
import polymod.format.ParseRules;
import thx.semver.VersionRule;
#if sys
import sys.FileSystem;
#end

class PolymodHandler
{
	public static var SCAN_DIRECTORY(get, never):String;
	public static final API_VERSION_RULE:VersionRule = '0.1.x';

	public static function initialize():Void
	{
		#if sys
		if (!FileSystem.exists(SCAN_DIRECTORY))
		{
			FileSystem.createDirectory(SCAN_DIRECTORY);
		}
		#end

		Polymod.init({
			modRoot: SCAN_DIRECTORY,
			framework: OPENFL,
			dirs: getAllDirs(),
			apiVersionRule: API_VERSION_RULE,
			parseRules: getParseRules(),
			useScriptedClasses: true
		});
	}

	private static function getAllDirs():Array<String>
	{
		var dirsToReturn:Array<String> = [];
		for (customConverter in Polymod.scan({modRoot: SCAN_DIRECTORY, apiVersionRule: API_VERSION_RULE}))
		{
			dirsToReturn.push(customConverter.id);
		}

		return dirsToReturn;
	}

	private static function getParseRules():ParseRules
	{
		var parseRules:ParseRules = ParseRules.getDefault();
		parseRules.addType('hxc', PLAINTEXT);
		parseRules.addType('hxs', PLAINTEXT);
		return parseRules;
	}

	static function get_SCAN_DIRECTORY():String
	{
		return Path.normalize(Path.join([System.getSaveDirectory(), 'CustomConverters']));
	}
}
