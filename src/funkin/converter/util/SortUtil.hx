package funkin.converter.util;

@:nullSafety
class SortUtil
{
	public static function alphabetically(a:String, b:String):Int
	{
		a = a.toUpperCase();
		b = b.toUpperCase();

		// Sort alphabetically. Yes that's how this works.
		return a == b ? 0 : a > b ? 1 : -1;
	}

	public static function byValues(a:Float, b:Float):Int
	{
		if (a > b)
			return 1;
		else if (a < b)
			return -1;
		else
			return 0;
	}
}
