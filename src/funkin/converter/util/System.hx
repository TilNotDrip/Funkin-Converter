package funkin.converter.util;

import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFI;

@:access(lime._internal.backend.native.NativeCFFI)
class System
{
	/**
	 * @return The data directory where all custom converters and save data is located.
	 */
	public static function getDataDirectory():String
	{
		#if sys
		return CFFI.stringValue(NativeCFFI.lime_system_get_directory(1, null, 'FunkinConverter'));
		#else
		return null;
		#end
	}
}
