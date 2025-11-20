package funkin.converter.ui;

import haxe.ui.containers.Box;
import haxe.ui.events.MouseEvent;
import openfl.Lib;

@:build(haxe.ui.ComponentBuilder.build("assets/exclude/ui/main-view.xml"))
class MainView extends Box
{
	public function new()
	{
		super();

		menubarFileExit.onClick = (event:MouseEvent) ->
		{
			Lib.application.window.close();
		}
	}
}
