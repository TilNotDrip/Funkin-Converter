package funkin.converter.format;

class Format
{
	public function new() {}

	public function getName():String
	{
		return 'Unknown';
	}

	public function toString():String
	{
		return 'Format<${getName()})>';
	}

	public function getDataTypes():Array<String>
	{
		return [];
	}
}
