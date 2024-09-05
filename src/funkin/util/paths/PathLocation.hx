package funkin.util.paths;

import openfl.utils.AssetType;
import openfl.utils.Assets;

class PathLocation
{
	public function new() {}

	/**
	 * Returns a audio path.
	 * @param key The audio name.
	 * @return default:assets/{key}.{Constants.EXT_AUDIO}
	 */
	public function audio(key:String):String
	{
		return get(key + '.' + Constants.EXT_AUDIO);
	}

	/**
	 * Returns a image path.
	 * @param key The image name.
	 * @return default:assets/images/{key}.{Constants.EXT_IMAGE}
	 */
	public function image(key:String):String
	{
		return get('images/' + key + '.' + Constants.EXT_IMAGE);
	}

	/**
	 * Returns a font path.
	 * @param key The font file.
	 * @return default:assets/fonts/{key}
	 */
	public function font(key:String):String
	{
		return get('fonts/' + key);
	}

	/**
	 * Returns a music path.
	 * @param key The music name.
	 * @return default:assets/music/{key}.{Constants.EXT_AUDIO}
	 */
	public function music(key:String):String
	{
		return audio('music/' + key);
	}

	/**
	 * Returns a sound path.
	 * @param key The sound name.
	 * @return default:assets/sounds/{key}.{Constants.EXT_AUDIO}
	 */
	public function sound(key:String):String
	{
		return audio('sounds/' + key);
	}

	/**
	 * Returns whether a path exists.
	 * @param key The key to check. (.get is not called, you have to do it yourself!)
	 * @param type The OpenFL Asset Type.
	 * @return Whether key exists.
	 */
	public function exists(key:String, ?type:AssetType):Bool
	{
		return Assets.exists(key, type);
	}

	/**
	 * Returns a regular path.
	 * @param key A asset key to add to this path.
	 * @return default:assets/{key}
	 */
	public function get(key:String):String
	{
		return 'default:assets/' + key;
	}
}
