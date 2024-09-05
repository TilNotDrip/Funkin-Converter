package;

#if FUNKIN_DISCORD_RPC
import funkin.api.DiscordRPC;
#end
import funkin.pages.WelcomePage;
import funkin.ui.Page;
import funkin.util.paths.Paths;
import haxe.ui.Toolkit;
import haxe.ui.focus.FocusManager;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.media.Sound;

class Main extends Sprite
{
	/**
	 * An instance of this class.
	 */
	public static var instance:Main = null;

	/**
	 * The page that the user is currently on right now.
	 */
	public var curPage(default, set):Page;

	public function new()
	{
		instance = this;

		super();

		initialize();
	}

	function initialize():Void
	{
		initHaxeUI();
		initApp();
		cacheClickSounds();

		#if FUNKIN_DISCORD_RPC
		DiscordRPC.initialize();
		#end
	}

	var firstBgWidth:Float = 0;

	function initApp():Void
	{
		var bg:Bitmap = new Bitmap(Paths.content.image('background'));
		firstBgWidth = bg.width;
		bg.bitmapData.colorTransform(bg.bitmapData.rect, new ColorTransform((45 / 255), (45 / 255), (45 / 255)));
		bg.smoothing = true;
		addChild(bg);

		curPage = new WelcomePage();

		stage.addEventListener('resize', (listener) ->
		{
			bg.scaleX = bg.scaleY = stage.stageWidth / firstBgWidth;

			// TODO: This is fucked on web for whatever reason.
			bg.x = (bg.width - stage.stageWidth) / 2;
			bg.y = (bg.height - stage.stageHeight) / 2;
		});

		stage.addEventListener(MouseEvent.MOUSE_DOWN, (listener:MouseEvent) ->
		{
			var clickDown:Sound = Paths.content.sound('clickDown');
			clickDown.play();
		});

		stage.addEventListener(MouseEvent.MOUSE_UP, (listener:MouseEvent) ->
		{
			var clickUp:Sound = Paths.content.sound('clickUp');
			clickUp.play();
		});
	}

	function initHaxeUI():Void
	{
		Toolkit.init();
		Toolkit.theme = 'dark'; // Don't be cringe.
		FocusManager.instance.autoFocus = false;
	}

	function cacheClickSounds():Void
	{
		Paths.content.sound('clickDown');
		Paths.content.sound('clickUp');
	}

	function set_curPage(newPage:Page):Page
	{
		if (curPage != null)
		{
			curPage.removeChildren();
			removeChild(curPage);
		}

		addChild(newPage);
		return newPage;
	}
}
