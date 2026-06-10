package;

import funkin.converter.format.FormatRegistry;
import funkin.converter.modding.PolymodHandler;
import funkin.converter.ui.MainView;
import funkin.converter.ui.dialogs.WelcomeDialog;
import funkin.converter.util.native.Native;
import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;
import lime.app.Application;
import lime.ui.Window;
import openfl.display.Sprite;

@:nullSafety
class Main extends Sprite
{
	public static var instance:Null<Main>;

	public var app:HaxeUIApp;

	public function new()
	{
		app = new HaxeUIApp();

		instance = this;

		super();

		Native.setDPIAware();

		PolymodHandler.initialize();
		FormatRegistry.instance.loadEntries();

		Toolkit.init();
		Toolkit.theme = 'funkin-dark';

		// OpenFL by default is about 30 fps so we will just match it to the user's refresh rate.
		var currentWindow:Window = Application.current.window;
		currentWindow.frameRate = currentWindow.displayMode.refreshRate;

		app.ready(() ->
		{
			var mainView:MainView = new MainView();
			mainView.addComponent(new WelcomeDialog());
			app.addComponent(mainView);

			app.start();
		});
	}
}
