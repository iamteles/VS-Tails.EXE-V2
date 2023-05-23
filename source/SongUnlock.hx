package;

import flixel.FlxG;
using StringTools;

class SongUnlock
{
	public static var initsongUnlocks:Map<String, Dynamic> = [
		'Chasing' => [true],
		'Darkness' => [false],
		'Rivals' => [false],
		'Reverie' => [false],
		'Sidekick' => [false],
		'Starshine' => [false],
		'Coughing' => [false],
		'Hatch' => [false],
		'Levitating' => [false],
		'Soic' => [false],
		'Nightmare' => [false],
	];

	public static var songUnlocks:Map<String, Dynamic> = [];

	public static function initialize():Void
	{
		FlxG.save.bind('songUnlocks', 'teles/VSTails');

		for (song in initsongUnlocks.keys())
			songUnlocks.set(song, initsongUnlocks.get(song)[0]);

		if (FlxG.save.data.songUnlocks != null)
		{
			var songUnlocksMap:Map<String, Dynamic> = FlxG.save.data.songUnlocks;
			for (song in songUnlocksMap.keys())
				if (initsongUnlocks.get(song) != null)
					songUnlocks.set(song, FlxG.save.data.songUnlocks.get(song));
		}
		saveSettings();
	}

	public static function saveSettings():Void
	{
		FlxG.save.data.songUnlocks = songUnlocks;
		FlxG.save.flush();
		trace('Saved songs');
	}

	public static function returnType(optionToGet:String)
	{
		return initsongUnlocks.get(optionToGet)[1];
	}

	public static function getUnlock(optionToGet:String)
	{
		return songUnlocks.get(optionToGet);
	}
	public static function getStoryStatus() {
		var count:Int = 0;

		for (song in ['Chasing', 'Darkness', 'Rivals', 'Reverie', 'Sidekick']) {
			if (getUnlock(song))  count++;
		}

		return count;
	}
	public static function unlockSong(unlockThis:String)
	{
		songUnlocks.set(unlockThis, true);
		trace('unlocked $unlockThis');
		//saveSettings();
	}
}