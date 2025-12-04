package flixel.util;

/**
 * @see https://github.com/larsiusprime/polymod/issues/267
 */
abstract FlxColor(Int) from Int from UInt to Int to UInt
{
	private static inline final VARIABLE_TO_MAKE_POLYMOD_HAPPY:FlxColor = 0;
}
