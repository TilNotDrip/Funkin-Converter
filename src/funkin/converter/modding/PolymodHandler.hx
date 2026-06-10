package funkin.converter.modding;

import funkin.converter.util.System;
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
			parseRules: ParseRules.getDefault(),
			useScriptedClasses: true,
			errorCallback: error -> {} // TODO
		});

		// TODO: make this async
		Polymod.registerAllScriptClasses();
	}

	private static function getAllDirs():Array<String>
	{
		final metadatas:Array<ModMetadata> = Polymod.scan({modRoot: SCAN_DIRECTORY, apiVersionRule: API_VERSION_RULE});
		return metadatas.map(metadata -> metadata.dirName);
	}

	static function get_SCAN_DIRECTORY():String
	{
		return Path.normalize(Path.join([System.getDataDirectory(), 'CustomConverters']));
	}
}
