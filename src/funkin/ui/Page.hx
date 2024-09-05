package funkin.ui;

import haxe.ui.containers.Box;

@:build(haxe.ui.ComponentBuilder.build("assets/ui/main-view.xml"))
class Page extends Box
{
	public function new()
	{
		super();
	}

	/**
	 * Switches this page with another one.
	 * @param nextPage The next page to go to.
	 */
	public function switchPage(nextPage:Page):Void
	{
		Main.instance.curPage = nextPage;
	}
}
