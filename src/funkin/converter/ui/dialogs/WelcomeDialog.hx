package funkin.converter.ui.dialogs;

import funkin.converter.formats.Engine;
import haxe.ui.components.Link;
import haxe.ui.containers.dialogs.Dialog;

@:build(haxe.ui.ComponentBuilder.build("assets/exclude/ui/dialogs/welcome-dialog.xml"))
class WelcomeDialog extends Dialog
{
	public function new()
	{
		super();

		for (engine in Engine.engines)
		{
			var engineLink:Link = new Link();
			engineLink.text = engine.name;

			if (engine.custom)
			{
				welcomeDialogCustomConverters.addComponent(engineLink);
			}
			else
			{
				welcomeDialogBuiltInConverters.addComponent(engineLink);
			}
		}
	}
}
