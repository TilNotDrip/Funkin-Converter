package funkin.converter.ui.dialogs;

import funkin.converter.format.Format;
import funkin.converter.format.FormatRegistry;
import haxe.ui.components.Link;
import haxe.ui.containers.dialogs.Dialog;
import haxe.ui.core.Component;
import haxe.ui.events.MouseEvent;

@:build(haxe.ui.ComponentBuilder.build("assets/exclude/ui/dialogs/welcome-dialog.xml"))
class WelcomeDialog extends Dialog
{
	public function new()
	{
		super();

		final formatIds:Array<String> = FormatRegistry.instance.listEntryIds();

		var defaultIds:Array<String> = formatIds.filter(v -> !FormatRegistry.instance.isModded(v));
		var moddedIds:Array<String> = formatIds.filter(v -> FormatRegistry.instance.isModded(v));

		createLinks(defaultIds, this.defaultFormats);
		createLinks(moddedIds, this.modFormats);

		uploadBG.registerEvent(MouseEvent.MOUSE_OVER, onMouseOverUpload);
		uploadBG.registerEvent(MouseEvent.MOUSE_OUT, onMouseOutUpload);
	}

	public function showDataTypes(id:String):Void
	{
		final format:Format = FormatRegistry.instance.fetchEntry(id);
		if (format == null)
			return;

		this.dataTypes.removeAllComponents(true);

		for (name in format.getDataTypes())
		{
			final link:Link = new Link();
			link.text = name;
			this.dataTypes.addComponent(link);
		}
	}

	function createLinks(list:Array<String>, component:Component):Void
	{
		var ids:Array<String> = list.copy();
		ids.sort((firstId:String, secondId:String) ->
		{
			final firstFormat:Format = FormatRegistry.instance.fetchEntry(firstId);
			final secondFormat:Format = FormatRegistry.instance.fetchEntry(secondId);
			return SortUtil.alphabetically(firstFormat.getName(), secondFormat.getName());
		});

		for (id in ids)
		{
			final format:Format = FormatRegistry.instance.fetchEntry(id);

			final link:Link = new Link();
			link.text = format?.getName() ?? 'Unknown';
			link.id = id;
			link.onClick = _ -> showDataTypes(id);

			component.addComponent(link);
		}
	}

	function onMouseOverUpload(_:MouseEvent):Void
	{
		uploadBG.swapClass('upload-bg', 'upload-bg-hover');
	}

	function onMouseOutUpload(_:MouseEvent):Void
	{
		uploadBG.swapClass('upload-bg-hover', 'upload-bg');
	}
}
