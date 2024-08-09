package funkin.pages;

import funkin.ui.welcome.components.MainView;

class WelcomePage extends Page
{
	var mainView:MainView;

	public function new()
	{
		super();

		mainView = new MainView();
		mainView.character_convert.onClick = function(e)
		{
			switchPage(new CharacterPage());
		}
		addChild(mainView);
	}
}
