package funkin.ui;

class Page extends Sprite
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
