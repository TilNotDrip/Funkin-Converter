package funkin.converter.ui;

import haxe.ui.containers.Box;
import haxe.ui.events.MouseEvent;
import openfl.media.Sound;
import openfl.media.SoundChannel;

@:build(haxe.ui.ComponentBuilder.build("assets/exclude/ui/main-view.xml"))
// @:nullSafety // TODO: uncomment this once HaxeUI has null-safety.
class MainView extends Box
{
	/**
	 * The path to the background music, also known as artistic expression.
	 */
	public static final BACKGROUND_MUSIC_PATH:String = 'assets/music/artisticExpression.ogg';

	/**
	 * The internal sound class of the background music.
	 * This is loaded asynchronously, so be careful!
	 */
	public var backgroundMusic:Null<Sound>;

	/**
	 * The internal `SoundChannel` of the background music.
	 * This gets destroyed and nullified everytime it ends, loops, or stops.
	 */
	var backgroundMusicChannel:Null<SoundChannel>;

	public function new()
	{
		super();

		menubarFileExit.onClick = (event:MouseEvent) ->
		{
			Lib.application.window.close();
		}

		menubarAudioBackgroundMusic.onClick = handleBackgroundMusic;

		initMusic();
	}

	/**
	 * Loads the background music.
	 */
	public function initMusic():Void
	{
		Assets.loadSound(BACKGROUND_MUSIC_PATH).onComplete((sound:Sound) ->
		{
			backgroundMusic = sound;
			handleBackgroundMusic();
		});
	}

	/**
	 * Handles background music playback.
	 * @param _ A dummy parameter for anything.
	 */
	public function handleBackgroundMusic(?_:Null<Dynamic>):Void
	{
		if (menubarAudioBackgroundMusic.selected)
		{
			backgroundMusicChannel?.stop();
			backgroundMusicChannel?.removeEventListener('soundComplete', handleBackgroundMusic);

			backgroundMusicChannel = backgroundMusic?.play();
			backgroundMusicChannel?.addEventListener('soundComplete', handleBackgroundMusic);
		}
		else
		{
			backgroundMusicChannel?.stop();
			backgroundMusicChannel = null;
		}
	}
}
