package;

import funkin.converter.Asset;
import funkin.converter.formats.Engine;
import funkin.converter.modding.PolymodHandler;
import funkin.converter.ui.MainView;
import funkin.converter.ui.dialogs.WelcomeDialog;
import haxe.io.Path;
import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;
import lime.app.Application;
import lime.ui.Window;
import openfl.display.Sprite;
import polymod.Polymod;

class Main extends Sprite
{
	public static var instance:Main = null;

	public var app:HaxeUIApp = null;

	public function new()
	{
		instance = this;

		super();

		PolymodHandler.initialize();
		registerModdedAssets();

		Engine.registerEngines();

		Toolkit.init();
		Toolkit.theme = 'dark';

		// OpenFL by default is about 30 fps so we will just match it to the user's refresh rate.
		var currentWindow:Window = Application.current.window;
		currentWindow.frameRate = currentWindow.displayMode.refreshRate;

		app = new HaxeUIApp();
		app.ready(() ->
		{
			var mainView:MainView = new MainView();
			mainView.addComponent(new WelcomeDialog());
			app.addComponent(mainView);

			app.start();
		});
	}

	private function registerModdedAssets():Void
	{
		@:privateAccess
		for (moddedAsset in Polymod.listModFiles())
		{
			Asset._moddedAssets.push(Path.join(['assets', moddedAsset]));
		}
	}
}
