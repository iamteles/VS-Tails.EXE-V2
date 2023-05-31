package;

import cpp.abi.Abi;
import haxe.io.Float64Array;
import cpp.Function;
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
import flixel.addons.display.FlxBackdrop;

using StringTools;

class GalleryState extends MusicBeatState
{
	public var curSelected:Int = 0;
	public static var items:Array<String> = ["sketches", "twitter", "poop", "nerd", "secret", "ourple", "true", "dside", "ohno", "brofrend", "pico", "dd", "awesomesolodude", "soicpromo", "concept", "eggsketch", "eggman", "gameover", "scrappednightmare", "scrappedfang", "collisionchaos", "teaser", "ost", "oldpromo", "finalescape", "oldhall", "oldhatch", "oldpixel", "scrappedtherm", "scrappedtherm2", "stagetest", "oldknuxbg", "foreversidekick", "whatthe", "great", "earlysoic", "prereboot", "prerebootexe", "prerebootexe2", "prereboottails3", "prereboottails1", "prerebootknux", "prerebootegg", "oldbf", "prerebootgf", "prerebooticons", "exebf", "exebficon", "prerebootfp", "chasinglovania", "prerebootpromo", "prev1"];
	public static var description:Array<String> = ["Early Tails and Knuckles sketches", "Twitter.", "why you gotta poop", "Ermmm actually", "secret???", "why he ray", "Quick!! Tell a lie!!", "D-Sides Tails.EXE", "oh no", "Brofrend", "Scrapped Pico reskin", "Daddy Dearest concept", "var awesomesolodude:FlxSprite;", "Soic promo art", "Gameplay concept", "Eggman sketch", "Scrapped Eggman design", "Game Over Screen", "Scrapped Tails for OG Nightmare concept", "Scrapped Sonic VS Fang", 
    "Scrapped Collision Chaos BG", "Teaser art", "OST art", "Promo art", "Final Escape", "Old Hall BG", "Upcoming remade Origin Eggman", "Old GG Sonic", "Scrapped character, might be reused", "Scrapped character (pixel art)", "Early gameplay", "Old SBZ BG", "Early Sidekick", "What the", "Awesome", "Early Soic gameplay", "Pre-Reboot gameplay", "Very early Pre-Reboot Tails.EXE", "Early Pre-Reboot Tails.EXE and Tails", "Early Pre-Reboot Tails (recolored)", "Very early Pre-Reboot Tails", "Early Pre-Reboot Knuckles", "Early Pre-Reboot Eggman", "Early Pre-Reboot Boyfriend", "Early Pre-Reboot Girlfriend", "Early Pre-Reboot icons", "EXE BF", "EXE BF's icons", "Early Pre-Reboot Freeplay", "Chasinglovania", "Early Pre-Reboot promo art", "Earliest gameplay footage (pre v1)"];
	public static var peopleMade:Array<String> = ["FenixTheCat", "FenixTheCat", "MA", "FenixTheCat", "Deflio", "FenixTheCat", "MA", "", "Pol", "Astro_Galaxy", "Astro_Galaxy", "MA", "MA", "Deflio","teles, FenixTheCat", "c0_rps3", "MA", "MA", "Sar", "teles", "MA", "MA", "GoodieBag", "Crispy", "FenixTheCat", "MA", "Tan", "Crispy", "Crispy", "Crispy", "Trikunari", "Trikunari", "Multiple", "Astro_Galaxy", "TonnoBuono", "Deflio", "Multiple", "Hampter", "Hampter", "Hampter", "Hampter", "Hampter", "Hampter", "Astro_Galaxy", "StMoloch", "Hampter", "Astro_Galaxy", "Astro_Galaxy", "teles", "Multiple", "Hampter", "OG VS EXE team, teles"];
	public static var bgs:Array<String> = ["menuBGblurred"];
	public var menuItems:FlxTypedGroup<FlxSprite>;

	var tipTextArray:Array<String> = "E/Q - Camera Zoom
	\nR - Reset Camera Zoom
	\nArrow Keys - Scroll\n".split('\n');

	var zoomAmmount:Int = 100;

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var itemScale:Float = 1;

	var descText:FlxText;
	var descTextTwo:FlxText;



	public override function create()
	{
		super.create();
		#if mobile
    addVirtualPad(LEFT_RIGHT, B);
    #end
		menuItems = new FlxTypedGroup<FlxSprite>();

		if (!FlxG.sound.music.playing || FlxG.sound.music.volume == 0)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}
	
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

		for(i in 0...items.length)
		{
			var item:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("gallery/" + items[i].toLowerCase(), 'sadfox'));
			item.screenCenter(X);
			item.screenCenter(Y);
			menuItems.add(item);

			item.ID = i;
		}

		add(menuItems);

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("hud.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		descTextTwo = new FlxText(50, 640, 1180, "", 32);
		descTextTwo.setFormat(Paths.font("hud.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descTextTwo.scrollFactor.set();
		descTextTwo.borderSize = 2.4;
		add(descTextTwo);

		for (i in 0...tipTextArray.length-1)
		{
			var tipText:FlxText = new FlxText(FlxG.width - 320, FlxG.height - 15 - 16 * (tipTextArray.length - i), 300, tipTextArray[i], 12);
			tipText.setFormat(Paths.font("hud.ttf"), 24, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
			tipText.scrollFactor.set();
			tipText.borderSize = 2.4;
			add(tipText);
		}

		leftArrow = new FlxSprite().loadGraphic(Paths.image("menustuff/main/arrow", 'sadfox'));
		leftArrow.y = 270;
		leftArrow.x = 0;
        leftArrow.visible = false;


		rightArrow = new FlxSprite().loadGraphic(Paths.image("menustuff/main/arrow", 'sadfox'));
		rightArrow.y = 270;
		rightArrow.x = 1100;
		rightArrow.flipX = true;
        rightArrow.visible = false;

		add(leftArrow);
		add(rightArrow);
		
	}
	var daChangingSpeedLerpYeRatioA:Float = 0.2;
	var startedChangeState:Bool = false;
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if(controls.UI_LEFT_P)
			changeItem(-1);
		if(controls.UI_RIGHT_P)
			changeItem(1);
		if(controls.UI_LEFT)
		{
			leftArrow.color = FlxColor.YELLOW;
			leftArrow.alpha = 0.95;
			leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.55));
			itemScale = 1;
		}
		else
		{
			leftArrow.color = FlxColor.WHITE;
			leftArrow.alpha = 0.95;
			leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.5));
		}
		if(controls.UI_RIGHT)
		{
			rightArrow.color = FlxColor.YELLOW;
			rightArrow.alpha = 0.95;
			rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.55));
			itemScale = 1;
		}
		else
		{
			rightArrow.color = FlxColor.WHITE;
			rightArrow.alpha = 0.95;
			rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.5));
		}

		if (FlxG.keys.justPressed.R) {
			itemScale = 1;
		}

		
		if (FlxG.keys.pressed.E && itemScale < 3) {
			itemScale += elapsed * itemScale;
			if(itemScale > 3) itemScale = 3;
		}
		if (FlxG.keys.pressed.Q && itemScale > 0.1) {
			itemScale -= elapsed * itemScale;
			if(itemScale < 0.1) itemScale = 0.1;
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}

		menuItems.forEach(function(item:FlxSprite)
		{
			if(item.ID == curSelected)
			{
				item.visible = true;

				item.setGraphicSize(Std.int(item.width * itemScale));
			}
			else
			{
				item.visible = false;
			}
		});

		descText.text = description[curSelected];
		descTextTwo.text = peopleMade[curSelected];
	}
	function changeItem(val:Int = 0)
	{
		curSelected += val;

		if (curSelected >= items.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = items.length - 1;
		// there was code using FlxTween but its sucks so im using Lerp instead
	}
}