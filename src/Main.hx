package;

import haxe.ui.HaxeUIApp;

class Main
{
	public static function main():Void
	{
		var app = new HaxeUIApp();
		app.ready(() ->
		{
			app.start();
		});
	}
}
