package funkin.converter;

abstract Asset(String) from String to String
{
	public static inline final SOUND_EXT:String = #if web 'mp3' #else 'ogg' #end;

	/**
	 * An array of assets that has been replaced/added by all polymods.
	 */
	public static var moddedAssets(get, never):Array<Asset>;

	private static var _moddedAssets:Array<Asset> = [];

	public function isModded():Bool
	{
		return moddedAssets.contains(this);
	}

	public static function get_moddedAssets():Array<Asset>
	{
		return _moddedAssets;
	}
}
