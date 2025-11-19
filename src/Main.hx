package;

import funkin.converter.ui.MainView;
import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;
import lime.app.Application;
import lime.ui.Window;
import openfl.display.Sprite;

class Main extends Sprite
{
	var app:HaxeUIApp;

	public function new()
	{
		super();

		app = new HaxeUIApp();
		app.ready(() ->
		{
			Toolkit.init();
			Toolkit.theme = 'dark';

			// OpenFL by default is about 30 fps so we will just match it to the user's refresh rate.
			var currentWindow:Window = Application.current.window;
			currentWindow.frameRate = currentWindow.displayMode.refreshRate;

			app.addComponent(new MainView());
			app.start();
		});
	}
}
