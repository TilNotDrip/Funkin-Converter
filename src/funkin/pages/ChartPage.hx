package funkin.pages;

import funkin.ui.MenuBar;

class ChartPage extends Page
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
