package;

import haxe.ui.HaxeUIApp;

class Main
{
	public static function main()
	{
		initialize();
	}

	static function initialize():Void
	{
		initHaxeUI();
	}

	static function initHaxeUI():Void
	{
		var app:HaxeUIApp = new HaxeUIApp();

		app.ready(function()
		{
			app.addComponent(new MainView());

			app.start();
		});
	}
}
