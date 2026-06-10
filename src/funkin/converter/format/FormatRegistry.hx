package funkin.converter.format;

import funkin.converter.modding.ScriptedFormat;
import funkin.converter.util.macro.ClassMacro;

class FormatRegistry
{
	public static var instance(get, never):FormatRegistry;

	static var _instance:Null<FormatRegistry> = null;

	static function get_instance():FormatRegistry
	{
		if (_instance == null)
			_instance = new FormatRegistry();

		return _instance;
	}

	var entries:Map<String, Format>;

	public function new()
	{
		entries = [];
	}

	public function loadEntries():Void
	{
		for (subClass in ClassMacro.listSubclassesOf(Format))
		{
			if (subClass == ScriptedFormat || subClass == Format)
				continue;

			final instance:Format = Type.createInstance(subClass, []);
			final id:String = Type.getClassName(subClass);

			entries.set(id, instance);
		}

		for (id in ScriptedFormat.listScriptClasses())
		{
			final instance:Null<Format> = ScriptedFormat.scriptInit(id);
			if (instance == null)
				continue;

			entries.set(id, instance);
		}

		trace('Loaded ${listEntryIds().length} formats: ${listEntryIds().join(', ')}');
	}

	public function fetchEntry(id:String):Null<Format>
	{
		return entries.get(id);
	}

	public function listEntryIds():Array<String>
	{
		return [for (i in entries.keys()) i];
	}

	public function isModded(id:String):Bool
	{
		var format:Null<Format> = fetchEntry(id);
		return Std.isOfType(format, ScriptedFormat);
	}
}
