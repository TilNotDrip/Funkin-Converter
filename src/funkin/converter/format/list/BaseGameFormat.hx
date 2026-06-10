package funkin.converter.format.list;

class BaseGameFormat extends Format
{
	override public function getName():String
	{
		return "Funkin' (Base Game)";
	}

	override public function getDataTypes():Array<String>
	{
		return ['Chart (pre-0.3.0)', 'Chart (0.3.0)', 'Character', 'Stage'];
	}
}
