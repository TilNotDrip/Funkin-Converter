package funkin.util.paths;

import haxe.Exception;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.media.Sound;
import openfl.system.System;

class PathContent
{
	var cachedAudioKeys:Array<String> = [];
	var cachedImageKeys:Array<String> = [];

	public function new() {}

	/**
	 * Caches and returns an OpenFL Sound instance of an audio.
	 * @param key The audio name.
	 * @return Sound instance of an audio.
	 */
	public function audio(key:String):Sound
	{
		var audio:Sound = null;

		if (!Assets.cache.hasSound(key))
		{
			try
			{
				audio = Assets.getSound(key, true);
				cachedAudioKeys.push(key);
			}
			catch (e:Exception)
			{
				trace('[WARNING]: Couldn\'t load audio ($key)');
				return null;
			}
		}
		else
		{
			audio = Assets.cache.getSound(key);
		}

		return audio;
	}

	/**
	 * Returns and caches a OpenFL BitmapData instance of an image.
	 * @param key The image name.
	 * @return BitmapData instance of an image.
	 */
	public function image(key:String):BitmapData
	{
		var assetKey:String = Paths.location.image(key);
		var bitmap:BitmapData = null;

		if (!Assets.cache.hasBitmapData(assetKey))
		{
			try
			{
				bitmap = Assets.getBitmapData(assetKey, true);
				cachedImageKeys.push(assetKey);
			}
			catch (e:Exception)
			{
				trace('[WARNING]: Couldn\'t load bitmap ($assetKey)');
				return null;
			}
		}
		else
		{
			bitmap = Assets.cache.getBitmapData(assetKey);
		}

		return bitmap;
	}

	/**
	 * Caches and returns an OpenFL Sound instance of a music audio.
	 * @param key The music name.
	 * @return Sound instance of an audio.
	 */
	public function music(key:String):Sound
	{
		return audio(Paths.location.music(key));
	}

	/**
	 * Caches and returns an OpenFL Sound instance of a sound audio.
	 * @param key The sound name.
	 * @return Sound instance of an audio.
	 */
	public function sound(key:String):Sound
	{
		return audio(Paths.location.sound(key));
	}

	/**
	 * Removes all currently cached audio from the audio cache.
	 */
	public function clearAudioCache():Void
	{
		for (audio in cachedAudioKeys)
		{
			removeFromAudioCache(audio);
		}

		System.gc();
	}

	/**
	 * Removes an image from the image cache.
	 * @param key The image to remove.
	 */
	public function removeFromAudioCache(key:String):Void
	{
		Assets.cache.removeSound(key);
		cachedAudioKeys.remove(key);
	}

	/**
	 * Removes all currently cached images from the image cache.
	 */
	public function clearImageCache():Void
	{
		for (image in cachedImageKeys)
		{
			removeFromImageCache(image);
		}

		System.gc();
	}

	/**
	 * Removes an image from the image cache.
	 * @param key The image to remove.
	 */
	public function removeFromImageCache(key:String):Void
	{
		Assets.cache.removeBitmapData(key);
		cachedImageKeys.remove(key);
	}
}
