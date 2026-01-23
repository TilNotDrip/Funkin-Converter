package funkin.converter.util.native;

class Native
{
	public static function setDPIAware():Void
	{
		#if windows
		Windows.setDPIAware();
		#end
	}
}
