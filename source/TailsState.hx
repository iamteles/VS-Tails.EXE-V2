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
import flixel.util.FlxTimer;

using StringTools;

class TailsState extends MusicBeatState
{
	var sega:FlxSprite;
	var psych:FlxSprite;
	var initialized:Bool = false;
	var startButton:FlxSprite;
	
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Title", null);
		#end

        //FlxG.sound.playMusic(Paths.music('freakyMenu'));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		sega = new FlxSprite(0).loadGraphic(Paths.image('menustuff/titleboot/sega', 'sadfox'));
		sega.screenCenter();
		sega.alpha = 0;
		add(sega);

		psych = new FlxSprite(0).loadGraphic(Paths.image('menustuff/titleboot/psych', 'sadfox'));
		psych.screenCenter();
		psych.alpha = 0;
		add(psych);

		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menustuff/titleboot/bg', 'sadfox'));
        bg.setGraphicSize(Std.int(bg.width * 3.2));
        bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = false;
		bg.visible = false;
		add(bg);

        var title:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menustuff/titleboot/tails', 'sadfox'));
        title.setGraphicSize(Std.int(title.width * 3.2));
        title.updateHitbox();
		title.screenCenter();
        title.y += 20;
		title.antialiasing = false;
		title.visible = false;
		add(title);

		startButton = new FlxSprite(0, 500).loadGraphic(Paths.image('menustuff/titleboot/start', 'sadfox'));
		startButton.updateHitbox();
		startButton.screenCenter(X);
		startButton.visible = false;
		add(startButton);

		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('sega'), 1.5);
			FlxTween.tween(sega, {alpha: 1}, 0.8, {ease: FlxEase.sineInOut, onComplete: function(twn:FlxTween) {
				new FlxTimer().start(1.3, function(tmr:FlxTimer)
					{
						FlxTween.tween(sega, {alpha: 0}, 0.8, {ease: FlxEase.sineInOut});
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							FlxTween.tween(psych, {alpha: 1}, 0.8, {ease: FlxEase.sineInOut});
							FlxG.sound.play(Paths.sound('psych'), 1.5);
	
							new FlxTimer().start(1.7, function(tmr:FlxTimer)
							{
								FlxTween.tween(psych, {alpha: 0}, 0.8, {ease: FlxEase.sineInOut});
	
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									FlxG.camera.flash(FlxColor.WHITE, 5);
									title.visible = true;
									bg.visible = true;
									///startButton.visible = true; -- lol
	
									initialized = true;
									FlxG.sound.playMusic(Paths.music('freakyMenu'));
									FlxG.sound.music.fadeIn(4, 0, 0.7);
								});
							});
						});
					});
				}});
		});

        FlxTween.tween(title, {y: title.y - 40}, 3, {type: FlxTweenType.PINGPONG, ease: FlxEase.sineInOut});

		super.create();

	}
	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		if (pressedEnter && initialized && !transitioning)
		{
			FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			FlxFlicker.flicker(startButton, 1.4, 0.06, false, false, function(flick:FlxFlicker)
			{
				MusicBeatState.switchState(new MainMenuState());
			});
		}
		super.update(elapsed);
	}
}