package funkin.ui;

import openfl.Lib;

class Page extends Sprite
{
	public function new()
	{
		super();
	}

	/**
	 * Adds a page and removes this one.
	 * @param page The new page to switch to.
	 */
	public function switchPage(page:Page):Void
	{
		removeChildren();
		Lib.current.removeChild(this);
		Lib.current.addChild(page);
	}
}
