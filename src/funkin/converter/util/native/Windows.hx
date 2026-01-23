package funkin.converter.util.native;

#if windows
@:cppFileCode('
#include <windows.h>
')
class Windows
{
	// Thanks to Psych and Codename for this function.
	@:functionCode('
        SetProcessDPIAware();
    ')
	public static function setDPIAware():Void {}
}
#end
