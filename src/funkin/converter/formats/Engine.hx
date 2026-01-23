package funkin.converter.formats;

import haxe.Json;
import haxe.io.Path;

@:nullSafety
class Engine
{
	public static var engines(get, never):Array<Engine>;

	private static var _engines:Array<Engine> = [];

	/**
	 * The identifier for this engine class.
	 * This is used inside of scripting.
	 */
	public final id:String;

	/**
	 * The display name for this engine class.
	 * This is used when it needs to be displayed on the application
	 */
	public final name:String;

	/**
	 * The value that returns whether it is an engine bundled with the application, or an unofficially made engine downloaded from a third-party source.
	 */
	public var custom:Bool = false;

	public var versions:Map<String, String> = [];

	public function new(id:String, name:String)
	{
		this.id = id;
		this.name = name;
	}

	public static function registerEngines():Void
	{
		for (textAsset in Assets.list(TEXT))
		{
			var curTextAsset:FunkinAsset = textAsset;

			if (!curTextAsset.startsWith('assets/data/engines/') || !curTextAsset.endsWith('.json'))
			{
				continue;
			}

			var engineJson:Dynamic = Json.parse(Assets.getText(textAsset));
			var engineObj:Engine = new Engine(Path.withoutDirectory(Path.withoutExtension(textAsset)), engineJson.name ?? 'Unknown');
			engineObj.versions = engineJson.versions ?? new Map<String, String>();
			engineObj.custom = curTextAsset.isModded();
			_engines.push(engineObj);
		}
	}

	public function toString():String
	{
		return '$name ($id)';
	}

	public static function get_engines():Array<Engine>
	{
		return _engines;
	}
}
