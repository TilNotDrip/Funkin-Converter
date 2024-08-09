package funkin.api;

#if FUNKIN_DISCORD_RPC
import hxdiscord_rpc.Discord;
import hxdiscord_rpc.Types;

/**
 * The Discord RPC handler for Funkin Converter.
 *
 * This contains quick functions like booting up the rpc.
 *
 * This also has variables that update the RPC when changed.
 */
class DiscordRPC
{
	/**
	 * The current Discord application ID that's being used right now.
	 */
	inline static final applicationId:String = '1271369174844837939';

	/**
	 * The user's current party status.
	 *
	 * Example:
	 * ```haxe
	 * "Looking to Play"
	 * "Playing Solo"
	 * "In a Group"
	 * ```
	 */
	public static var state(default, set):String;

	/**
	 * What the player is currently doing.
	 *
	 * Example:
	 * ```haxe
	 * "Competitive - Captain's Mode"
	 * "In Queue"
	 * "Unranked PvP"
	 * ```
	 */
	public static var details(default, set):String;

	/**
	 * epoch seconds for game start - including will show time as "elapsed".
	 *
	 * Sending `startTimestamp` will show "elapsed" as long as there is no `endTimestamp` sent.
	 *
	 * Example:
	 * ```haxe
	 * 1507665886
	 * ```
	 */
	public static var startTimestamp(default, set):Float;

	/**
	 * epoch seconds for game end - including will show time as "remaining"
	 *
	 * Sending `endTimestamp` will **always** have the time displayed as "remaining" until the given time.
	 *
	 * Example:
	 * ```haxe
	 * 1507665886
	 * ```
	 */
	public static var endTimestamp(default, set):Float;

	/**
	 * Name of the uploaded image for the large profile artwork.
	 *
	 * Example:
	 * ```haxe
	 * "default"
	 * ```
	 */
	public static var largeImageKey(default, set):String;

	/**
	 * Tooltip for the largeImageKey.
	 *
	 * Example:
	 * ```haxe
	 * "Blade's Edge Arena"
	 * "Numbani"
	 * "Danger Zone"
	 * ```
	 */
	public static var largeImageText(default, set):String;

	/**
	 * Name of the uploaded image for the small profile artwork.
	 *
	 * Example:
	 * ```haxe
	 * "rogue"
	 * ```
	 */
	public static var smallImageKey(default, set):String;

	/**
	 * Tooltip for the smallImageKey.
	 *
	 * Example:
	 * ```haxe
	 * "Rogue - Level 100"
	 * ```
	 */
	public static var smallImageText(default, set):String;

	/**
	 * ID of the player's party, lobby, or group.
	 *
	 * Example:
	 * ```haxe
	 * "ae488379-351d-4a4f-ad32-2b9b01c91657"
	 * ```
	 */
	public static var partyId(default, set):String;

	/**
	 * Current size of the player's party, lobby, or group.
	 *
	 * Example:
	 * ```haxe
	 * 1
	 * ```
	 */
	public static var partySize(default, set):Int;

	/**
	 * Maximum size of the player's party, lobby, or group.
	 *
	 * Example:
	 * ```haxe
	 * 5
	 * ```
	 */
	public static var partyMax(default, set):Int;

	/**
	 * No documentation was given on this.
	 */
	public static var partyPrivacy(default, set):Int;

	/**
	 * Unique hashed string for a player's match.
	 *
	 * Example:
	 * ```haxe
	 * "MmhuZToxMjMxMjM6cWl3amR3MWlqZA=="
	 * ```
	 */
	public static var matchSecret(default, set):String;

	/**
	 * Unique hashed string for Spectate button.
	 *
	 * Example:
	 * ```haxe
	 * "MTIzNDV8MTIzNDV8MTMyNDU0"
	 * ```
	 */
	public static var spectateSecret(default, set):String;

	/**
	 * Unique hashed string for chat invitations and Ask to Join.
	 *
	 * Example:
	 * ```haxe
	 * 	"MTI4NzM0OjFpMmhuZToxMjMxMjM="
	 * ```
	 */
	public static var joinSecret(default, set):String;

	static var presence:DiscordRichPresence = DiscordRichPresence.create();

	/**
	 * Initializes and boots up the Discord RPC.
	 */
	public static function initialize():Void
	{
		var handlers:DiscordEventHandlers = DiscordEventHandlers.create();
		handlers.ready = cpp.Function.fromStaticFunction(onReady);
		handlers.disconnected = cpp.Function.fromStaticFunction(onDisconnected);
		handlers.errored = cpp.Function.fromStaticFunction(onError);
		Discord.Initialize(applicationId, cpp.RawPointer.addressOf(handlers), 1, null);

		sys.thread.Thread.create(function():Void
		{
			while (true)
			{
				#if DISCORD_DISABLE_IO_THREAD
				Discord.UpdateConnection();
				#end
				Discord.RunCallbacks();

				Sys.sleep(2);
			}
		});
	}

	/**
	 * Restarts the Discord RPC by shutting it down and re-initializing it again.
	 */
	public static function restart():Void
	{
		shutdown();
		initialize();
	}

	/**
	 * Shuts down the Discord RPC.
	 */
	public static function shutdown():Void
	{
		Discord.Shutdown();
	}

	/**
	 * Resets all the values back to either null or 0 (if it's a number type.)
	 */
	public static function clearValues():Void
	{
		state = null;
		details = null;

		startTimestamp = 0;
		endTimestamp = 0;

		largeImageKey = null;
		largeImageText = null;

		smallImageKey = null;
		smallImageText = null;

		partyId = null;
		partySize = 0;
		partyMax = 0;
		partyPrivacy = 0;

		matchSecret = null;
		joinSecret = null;
		spectateSecret = null;
	}

	/**
	 * Updates the presence on the user's Discord profile.
	 */
	public static function updatePresence():Void
	{
		Discord.UpdatePresence(cpp.RawConstPointer.addressOf(presence));
	}

	// Handlers
	static function onReady(request:cpp.RawConstPointer<DiscordUser>):Void
	{
		var userName:String = cast(request[0].username, String);
		var userDiscrim:String = '';

		if (Std.parseInt(cast(request[0].discriminator, String)) != 0)
			userDiscrim += '#${cast (request[0].discriminator, String)}';

		updatePresence();

		trace('Discord RPC Successfully connected! ($userName$userDiscrim)');
	}

	static function onDisconnected(errorCode:Int, message:cpp.ConstCharStar):Void
	{
		trace('Discord RPC Disconnected! ($errorCode: ${cast (message, String)})');
	}

	static function onError(errorCode:Int, message:cpp.ConstCharStar):Void
	{
		trace('Discord RPC Error! ($errorCode: ${cast (message, String)})');
	}

	// Setting Discord RPC Variables
	static function set_state(value:String):String
	{
		presence.state = value;
		updatePresence();
		return value;
	}

	static function set_details(value:String):String
	{
		presence.details = value;
		updatePresence();
		return value;
	}

	static function set_startTimestamp(value:Float):Float
	{
		presence.startTimestamp = Std.int(value / 1000);
		updatePresence();
		return value;
	}

	static function set_endTimestamp(value:Float):Float
	{
		presence.endTimestamp = Std.int(value / 1000);
		updatePresence();
		return value;
	}

	static function set_largeImageKey(value:String):String
	{
		presence.largeImageKey = value;
		updatePresence();
		return value;
	}

	static function set_largeImageText(value:String):String
	{
		presence.largeImageText = value;
		updatePresence();
		return value;
	}

	static function set_smallImageKey(value:String):String
	{
		presence.smallImageKey = value;
		updatePresence();
		return value;
	}

	static function set_smallImageText(value:String):String
	{
		presence.smallImageText = value;
		updatePresence();
		return value;
	}

	static function set_partyId(value:String):String
	{
		presence.partyId = value;
		updatePresence();
		return value;
	}

	static function set_partySize(value:Int):Int
	{
		presence.partySize = value;
		updatePresence();
		return value;
	}

	static function set_partyMax(value:Int):Int
	{
		presence.partyMax = value;
		updatePresence();
		return value;
	}

	static function set_partyPrivacy(value:Int):Int
	{
		presence.partyPrivacy = value;
		updatePresence();
		return value;
	}

	static function set_matchSecret(value:String):String
	{
		presence.matchSecret = value;
		updatePresence();
		return value;
	}

	static function set_joinSecret(value:String):String
	{
		presence.joinSecret = value;
		updatePresence();
		return value;
	}

	static function set_spectateSecret(value:String):String
	{
		presence.spectateSecret = value;
		updatePresence();
		return value;
	}
}
#end
