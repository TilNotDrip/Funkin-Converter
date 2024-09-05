package funkin.ui;

import haxe.ui.containers.menus.Menu;
import haxe.ui.containers.menus.MenuBar as HaxeUIMenuBar;
import haxe.ui.containers.menus.MenuItem;
#if js
import js.Browser;
#end

class MenuBar extends HaxeUIMenuBar
{
	override public function new()
	{
		super();

		customStyle.percentWidth = 100;

		// EDIT
		// MAYBE VIEW
		// MAYBE HELP

		addComponent(buildFileMenu());
		addComponent(buildOptionsMenu());
	}

	function buildFileMenu():Menu
	{
		var file:Menu = new Menu();
		file.text = 'File';

		var openFileItem:MenuItem = new MenuItem();
		openFileItem.text = 'Open';
		openFileItem.shortcutText = 'CTRL+O';
		file.addComponent(openFileItem);

		var exitFileItem:MenuItem = new MenuItem();
		exitFileItem.text = 'Exit';
		exitFileItem.shortcutText = 'ALT+F4';
		exitFileItem.onClick = function(event)
		{
			#if sys
			Sys.exit(0);
			#elseif js
			Browser.window.close();
			#end
		};
		file.addComponent(exitFileItem);

		return file;
	}

	function buildOptionsMenu():Menu
	{
		var options:Menu = new Menu();
		options.text = 'Options';

		var audioOptionItem:MenuItem = new MenuItem();
		audioOptionItem.text = 'Audio';
		options.addComponent(audioOptionItem);

		var themeOptionItem:MenuItem = new MenuItem();
		themeOptionItem.text = 'Theme';
		options.addComponent(themeOptionItem);

		return options;
	}
}
