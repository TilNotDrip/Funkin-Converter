package;

#if FUNKIN_DISCORD_RPC
import funkin.api.DiscordRPC;
#end
import funkin.pages.WelcomePage;
import haxe.ui.Toolkit;
import haxe.ui.focus.FocusManager;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		initialize();
	}

	function initialize():Void
	{
		initHaxeUI();
		initApp();

		#if FUNKIN_DISCORD_RPC
		DiscordRPC.initialize();
		#end
	}

	function initApp():Void
	{
		var bg:Bitmap = new Bitmap(Assets.getBitmapData('assets/images/background.png'));
		bg.x = (stage.stageWidth - bg.width) / 2;
		bg.y = (stage.stageHeight - bg.height) / 2;
		addChild(bg);

		addChild(new WelcomePage());
	}

	function initHaxeUI():Void
	{
		Toolkit.init();
		Toolkit.theme = 'dark'; // Don't be cringe.
		FocusManager.instance.autoFocus = false;
	}
}
