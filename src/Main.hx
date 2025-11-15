package;

import funkin.converter.ui.MainView;
import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;
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

			app.addComponent(new MainView());
			app.start();
		});
	}
}
