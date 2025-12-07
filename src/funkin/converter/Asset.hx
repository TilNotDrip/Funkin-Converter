package funkin.converter;

abstract Asset(String) from String to String
{
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
