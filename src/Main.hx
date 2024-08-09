package;

import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;
import haxe.ui.focus.FocusManager;

class Main
{
	public static function main()
	{
		initialize();
	}

	static function initialize():Void
	{
		initHaxeUI();

		var app:HaxeUIApp = new HaxeUIApp();

		app.ready(function()
		{
			app.addComponent(new MainView());

			app.start();
		});
	}

	static function initHaxeUI():Void
	{
		Toolkit.init();
		Toolkit.theme = 'dark'; // Don't be cringe.
		FocusManager.instance.autoFocus = false;
	}
}
