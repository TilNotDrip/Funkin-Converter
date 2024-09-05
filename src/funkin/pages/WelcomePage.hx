package funkin.pages;

import funkin.ui.MenuBar;

/**
 * This is the welcome page.
 *
 * This is the first page the user sees.
 */
class WelcomePage extends Page
{
	/**
	 * The menu bar.
	 */
	public var menuBar:MenuBar;

	public function new()
	{
		super();

		buildMenuBar();
	}

	function buildMenuBar():Void
	{
		menuBar = new MenuBar();
		addComponent(menuBar);
	}
}
