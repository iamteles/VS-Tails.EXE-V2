package;

import FreeplayState.SongMetadata;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.addons.display.FlxBackdrop;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.3'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	
	public var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'extras', 'options'];

	public var forceCenter:Bool = true;

	public var menuItemScale:Int = 1;

	var spikyThing:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var camFollow:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();

		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var backdrop:FlxBackdrop;
		#if (flixel > "5.0.0")
		backdrop = new FlxBackdrop(Paths.image("menustuff/grid", 'sadfox'), XY, 0, 0);
		#else
		backdrop = new FlxBackdrop(Paths.image("menustuff/grid", 'sadfox'), 8, 8, true, true, 1, 1);
		#end
        backdrop.velocity.set(FlxG.random.bool(50) ? 90 : -90, FlxG.random.bool(50) ? 90 : -90);
        backdrop.screenCenter();
        backdrop.alpha = 0.4;
        add(backdrop);
		
		var maxArts:Int = switch (SongUnlock.getUnlock('Darkness')) {
			case false: 1;
			case true: 3;
		}
		var art:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("menustuff/rotation/" + FlxG.random.int(1, maxArts), 'sadfox'));
		add(art);

		spikyThing = new FlxSprite(0, 720 - 144).loadGraphic(Paths.image("menustuff/main/spikes", 'sadfox'));
		add(spikyThing);

		var vignette:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("menustuff/RedVG", 'sadfox'));
		add(vignette);
		vignette.alpha = 0.275;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var item:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("menustuff/main/" + optionShit[i].toUpperCase(), 'sadfox'));
			menuItems.add(item);
			item.x = spikyThing.getGraphicMidpoint().x - item.width / 2;
			item.y = 1200;
			item.ID = i;
		}

		leftArrow = new FlxSprite().loadGraphic(Paths.image("menustuff/main/arrow", 'sadfox'));
		leftArrow.y = spikyThing.getGraphicMidpoint().y - leftArrow.height / 2;
		leftArrow.x = spikyThing.getGraphicMidpoint().x - leftArrow.width / 2 - 500 / 2;

		rightArrow = new FlxSprite().loadGraphic(Paths.image("menustuff/main/arrow", 'sadfox'));
		rightArrow.y = spikyThing.getGraphicMidpoint().y - rightArrow.height / 2;
		rightArrow.x = spikyThing.getGraphicMidpoint().x - rightArrow.width / 2 + 500 / 2;
		rightArrow.flipX = true;

		add(leftArrow);
		add(rightArrow);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "VS Tails.EXE v2.0", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("Righteous", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		/*
		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end
		*/

    #if mobile
    addVirtualPad(LEFT_RIGHT, A_B);
    #end

		super.create();
	}

	/*
	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end
	*/

	var selectedSomethin:Bool = false;
	var lerpVal:Float = 0.2;
	var curWeek:WeekData;
    var songArray:Array<String> = [];

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				changeItem(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}


			if (controls.UI_RIGHT_P)
			{
				changeItem(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if(controls.UI_LEFT)
			{
				leftArrow.color = FlxColor.YELLOW;
				leftArrow.alpha = 0.95;
				leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.9));
			}
			else
			{
				leftArrow.color = FlxColor.WHITE;
				leftArrow.alpha = 0.95;
				leftArrow.setGraphicSize(Std.int(leftArrow.width * 1));
			}
			if(controls.UI_RIGHT)
			{
				rightArrow.color = FlxColor.YELLOW;
				rightArrow.alpha = 0.95;
				rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.9));
			}
			else
			{
				rightArrow.color = FlxColor.WHITE;
				rightArrow.alpha = 0.95;
				rightArrow.setGraphicSize(Std.int(rightArrow.width * 1));
			}

			if (controls.ACCEPT)
			{

				FlxG.sound.play(Paths.sound('confirmMenu'));

				/*
				FlxTween.tween(FlxG.camera, {y: -900}, 0.9, {
					ease: FlxEase.quadInOut
				});
				*/
				if (optionShit[curSelected] == 'ost')
					CoolUtil.browserLoad('https://distrokid.com/hyperfollow/teles1/vs-tailsexe-volume-1');
				else if (optionShit[curSelected] == 'discord')
					CoolUtil.browserLoad('https://discord.gg/a7UjAsBFFT');
				else {
					selectedSomethin = true;
					menuItems.forEach(function(spr:FlxSprite)
					{

							if (curSelected != spr.ID)
							{
								FlxTween.tween(spr, {alpha: 0}, 0.4, {
									ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										spr.kill();
									}
								});
							}
							else
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									var daChoice:String = optionShit[curSelected];

									switch (daChoice)
									{
										case 'extras':
											MusicBeatState.switchState(new ExtrasMenu());
										case 'story mode':
											PlayState.storyWeek = 0;
											var curWeekInt = PlayState.storyWeek;
					
											curWeek = WeekData.weeksLoaded.get(WeekData.weeksList[curWeekInt]);
											trace(curWeekInt);
											songArray = ['Chasing', 'Darkness', 'Rivals', 'Reverie', 'Sidekick'];
											
											PlayState.storyPlaylist = songArray;
											PlayState.isStoryMode = true;
							
											PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
											PlayState.campaignScore = 0;
											PlayState.campaignMisses = 0;
											LoadingState.loadAndSwitchState(new PlayState(), true);
											FreeplayState.destroyFreeplayVocals();
										case 'freeplay':
											MusicBeatState.switchState(new FreeplayState());
										#if MODS_ALLOWED
										case 'mods':
											MusicBeatState.switchState(new ModsMenuState());
										#end
										case 'awards':
											MusicBeatState.switchState(new AchievementsMenuState());
										case 'credits':
											MusicBeatState.switchState(new CreditsState());
										case 'options':
											LoadingState.loadAndSwitchState(new options.OptionsState());
									}
								});
							} 
				});
			}
			}
			#if desktop
			else if (FlxG.keys.justPressed.SEVEN && (ClientPrefs.areYouTeles || SongUnlock.getStoryStatus() <= 11))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(item:FlxSprite)
		{
			if(item.ID == curSelected)
			{
				item.x = CoolUtil.coolLerp(item.x, spikyThing.getGraphicMidpoint().x - item.width / 2, lerpVal);
				item.y = CoolUtil.coolLerp(item.y, spikyThing.getGraphicMidpoint().y - item.height / 2, lerpVal);
				item.color = CoolUtil.smoothColorChange(item.color, FlxColor.YELLOW, lerpVal);
				item.alpha = CoolUtil.coolLerp(item.alpha, 1, lerpVal);
			}
			else
			{
				item.y = CoolUtil.coolLerp(item.y, spikyThing.getGraphicMidpoint().y - item.height / 2 + 12, lerpVal);
				if(item.ID < curSelected)
				{
					item.x = CoolUtil.coolLerp(item.x, (-item.width / 2 * (curSelected - item.ID)) + 100 * (item.ID - curSelected + 1), lerpVal);
					item.color = CoolUtil.smoothColorChange(item.color, FlxColor.WHITE, lerpVal);
					item.alpha = CoolUtil.coolLerp(item.alpha, 0.7, lerpVal);
				}
				if(item.ID > curSelected)
				{
					item.x = CoolUtil.coolLerp(item.x, ((1280 - item.width / 2) * (item.ID - curSelected)) - 100 * (curSelected - item.ID + 1), lerpVal);
					item.color = CoolUtil.smoothColorChange(item.color, FlxColor.WHITE, lerpVal);
					item.alpha = CoolUtil.coolLerp(item.alpha, 0.7, lerpVal);
				}
			}
			});
	}

	var lastCurSelected:Int = 0;

	function changeItem(val:Int = 0)
	{
		curSelected += val;

		if (curSelected >= optionShit.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = optionShit.length - 1;
	}
}
