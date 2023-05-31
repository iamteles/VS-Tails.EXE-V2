package;


#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;

using StringTools;

class FlashingStateCool extends MusicBeatState
{
	public static var leftState = false;
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Intro", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('warning', 'sadfox'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		super.create();

	}

	override function update(elapsed:Float)
	{
	 #if mobile
		#if mobile
		for (touch in FlxG.touches.list) {
		 if (touch.justPressed && !leftState) //yes touch :)
		 {
			 leftState = true;
			 FlxG.switchState(new TitleState());
	         }
		}
   #else
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new TitleState());
		}
  #end
		super.update(elapsed);
	}
}