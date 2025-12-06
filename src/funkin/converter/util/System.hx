package funkin.converter.util;

import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFI;

@:access(lime._internal.backend.native.NativeCFFI)
class System
{
	public static function getSaveDirectory():String
	{
		#if sys
		return CFFI.stringValue(NativeCFFI.lime_system_get_directory(1, null, 'FunkinConverter'));
		#else
		return null;
		#end
	}
}
