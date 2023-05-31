package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.addons.display.FlxBackdrop;
import lime.utils.Assets;
import flixel.effects.FlxFlicker;

using StringTools;
using flixel.util.FlxSpriteUtil;

class CreditsState extends MusicBeatState
{
	static var curSelected:Int = -1;
	static var lessSelected:Int = -2;
	static var succSelected:Int = 0;

	private var optionText:FlxText;
	private var descText:FlxText;
	private var roleText:FlxText;
	// i know its shit coding but it works anyway
	private var icon:AttachedSprite;
	private var precIcon:AttachedSprite;
	private var succIcon:AttachedSprite;
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxBackdrop;
	var yummy:FlxSprite;
	var arrowItems:FlxTypedGroup<FlxSprite>;
	var spikeThignies:FlxTypedGroup<FlxSprite>;
	var lineStuff:FlxTypedGroup<FlxSprite>;
	var statiCazzo:FlxTypedGroup<FlxSprite>;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;

		FlxG.mouse.visible = true;

		bg = new FlxBackdrop(Paths.image("menustuff/grid", 'sadfox'), XY, 0, 0);
		// bg = new FlxBackdrop(Paths.image("menustuff/grid", 'sadfox'), 8, 8, true, true, 1, 1);
        bg.velocity.set(FlxG.random.bool(50) ? 90 : -90, FlxG.random.bool(50) ? 90 : -90);
        bg.screenCenter();
        bg.alpha = 0.4;
        add(bg);

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - Role
			['VS Tails.EXE Team'],
			['teles', 'teles', '1 year, i cant believe it', 'https://www.youtube.com/channel/UCHK83AQBjAc9sy0lE6m8e3A', 'Director, Musician, Coder, Animator'],
			['Astro_Galaxy', 'astro' ,'Space Journey when?', 'https://www.youtube.com/channel/UChhiMUkcTdDDpOiMPY0td5w', 'Artist, Animator'],
			['FenixTheCat', 'fenix' ,'insert text here', 'https://twitter.com/CatTheFenix', 'Artist'],
			['Coco puffs', 'corruption' ,'Three times did the cheese move sideways to Switzerland by radio, but..she never licked that parking permit', 'https://twitter.com/file_corruption', 'Artist, Animator, Composer'],		
			['Crispy', 'crispy' ,'el pepe', 'https://twitter.com/ZapatoImbecil', 'Artist'],
			['c0_rps3', 'c0' ,"Wow, ok", 'https://twitter.com/o_c0rps3', 'Artist'],
			['GoodieBag', 'goodie' ,'Erm what the scallop', 'https://twitter.com/GoodieBag78', 'Artist'],
			['Deflio', 'deflio' ,'OH YEAH THIS IS HAPPENING', 'https://www.youtube.com/channel/UCGqkiga9ZQX8AhTTs8oyh9Q', 'Artist, Animator'],
			['Hosky', 'face' ,'No quote', 'https://www.google.com', 'Artist'],
			['MA - 1AJ', 'ma' ,"I'm in an exe mod. The very thing I swore to destroy", 'https://twitter.com/1aj_ma', 'Artist'],
			['Sar', 'sar' ,'sar. only.', 'https://www.twitter.com/KalsperSar', 'Artist'],
			['Tan', 'tan' ,'It aint easy being cheesy', 'https://twitter.com/TanDoesStuff', 'Artist, Animator'],
			['Trikunari', 'triku' ,'What am i doing here', 'https://twitter.com/Trikunari', 'Background Artist'],
			['Blaze', 'blaze' ,'you play like a noob blocked', 'https://www.youtube.com/channel/UC_Yc5o7jz72e7j4B70c_gpQ', 'Artist, Animator'],
			['Anakim', 'anakim' ,'cw_amen04 170', 'https://www.youtube.com/@Anakim2', 'Musician'],
			['CharaWhy', 'chara' ,'Käi Putsi.', 'https://www.youtube.com/@CharaWhy', 'Musician'],
			['ROCKY', 'rocky' ,':neutral_face:', 'https://www.youtube.com/@rocky4772', 'Musician'],
			['Yupam', 'yup' ,'AGOOBAGOBAGOOOOOOBAAAAA', 'https://www.youtube.com/channel/UCgrVlJBKDSc8fUWy7S_PV1A', 'Musician'],
			['Leozito', 'leo' ,'ITS SEX SONIC, THEYRE TALKING ABOUT SE-', 'https://www.youtube.com/channel/UCfsqyinKiKsen2MiajkGogg', 'Voice Acting'],
			['RaiGuyyy', 'rai' ,'I hate FNF so fucking much', 'https://twitter.com/RaiGuyyy', 'Voice Acting'],
			['Mustard', 'mustard' ,'I came', 'https://twitter.com/Squijay1', 'Voice Acting'],
			['TonnoBuono', 'tuna' ,'How to press WASD', 'https://www.youtube.com/channel/UCaDJOerpCAIT7uUP28OKoZQ', 'Coding'],
			['YaBoiJustin', 'justin' ,'its me awesome', 'https://twitter.com/YaBoiJustinGG', 'Events Helper'],
			['HarryLTS', 'harry' ,'tails.exe for life', 'https://twitter.com/harry_lts', 'Charter'],
			['Xarion', 'xar' ,'play vs jeremy NOW', 'https://twitter.com/Xar1on', 'Charter'],
			['Diamond', 'diamond' ,'what would my quote be?', 'https://twitter.com/DiamonDiglett42', 'Charter, Animator'],
			['The rest of the team', 'team', 'Thanks to whoever didnt get their work featured in v2', '', 'Team'],
			['Tr1NgleDev', 'tr1ngle', "Menu assets and coding", 'https://github.com/Tr1NgleDev', 'Contributor'],
			['Sakurnyaw', 'sakurnyaw', "Eggy's Icon", 'https://twitter.com/Sakurnyaw', 'Contributor'],
			['DiogoTV', 'diogo', 'Coding Advice', 'https://twitter.com/DiogoTVV', 'Contributor'],
			['Unholywanderer04', 'unholy' ,'Combos Lua Script', 'https://gamebanana.com/members/1908754', 'Contributor'],
			['Loryx', 'loryx', 'Number 1 Tails.EXE fan', 'https://twitter.com/Loryx12', 'Special Thanks'],
			['five', 'five', 'teehee', 'https://twitter.com/FiveKimz', 'Special Thanks'],
			['Psych Engine',		'shadowmario',		'Press enter for Psych Engine + Funkin Crew credits',					'PsychCreditsState',	'Engine']
		];

		for(i in pisspoop){
			creditsStuff.push(i);
		}

		optionText = new FlxText(386, FlxG.height * 0.5 - 80, 0, "", 60);
		optionText.setFormat(Paths.font("avanzato.ttf"), 60, FlxColor.WHITE, LEFT, OUTLINE_FAST, FlxColor.BLACK);
		// optionText.screenCenter();
		add(optionText);

		roleText = new FlxText(optionText.width + 400, optionText.y + 30, 0, "", 30);
		roleText.setFormat(Paths.font("avanzato.ttf"), 30, FlxColor.RED, LEFT, OUTLINE_FAST, FlxColor.BLACK);
		add(roleText);

		descText = new FlxText(optionText.x, optionText.y + 70, 670, "", 30);
		descText.setFormat(Paths.font("avanzato.ttf"), 30, FlxColor.BLACK, LEFT, OUTLINE_FAST, FlxColor.WHITE);
		add(descText);

		precIcon = new AttachedSprite('credits/shadowmario');
		add(precIcon);

		icon = new AttachedSprite('credits/shadowmario');
		add(icon);

		succIcon = new AttachedSprite('credits/shadowmario');
		add(succIcon);

		// icons

		// these for positioning

		var thignie:FlxSprite = new FlxSprite(208, 278.1);
		var square:FlxSprite = new FlxSprite(558.5, 36);
		var employee:FlxSprite = new FlxSprite(558.5, 520.4);

		// x add

		icon.xAdd = 6;
		precIcon.xAdd = 6;
		succIcon.xAdd = 6;

		// y add

		icon.yAdd = 6;
		precIcon.yAdd = 6;
		succIcon.yAdd = 6;

		// sprtracking

		icon.sprTracker = thignie;
		precIcon.sprTracker = square;
		succIcon.sprTracker = employee;

		// end of icons

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);

			if(isSelectable) {
				if(curSelected == -1) curSelected = i;
			}
		}

		statiCazzo = new FlxTypedGroup<FlxSprite>();
		add(statiCazzo);

		for (l in 0...3){
			var coglio:FlxSprite = new FlxSprite(0, 0);
			coglio.frames = Paths.getSparrowAtlas('delfino/sheeto2', 'sadfox');
			coglio.setGraphicSize(150, 150);
			coglio.updateHitbox();
			coglio.screenCenter();
			coglio.animation.addByPrefix('cane','n', 24, true);
			coglio.animation.play('cane');
			coglio.alpha = 0.3;
			coglio.ID = l;

			switch (l)
			{
				case 0:
					coglio.setGraphicSize(854, 150);
					coglio.updateHitbox();
					coglio.x = 208 + 6;
					coglio.y = 278.1 + 6;
				case 1:
					coglio.x = 558.5 + 6;
					coglio.y = 36 + 6;
				case 2:
					coglio.x = 558.5 + 6;
					coglio.y = 520.4 + 6;
			}

			statiCazzo.add(coglio);
		}

		lineStuff = new FlxTypedGroup<FlxSprite>();
		add(lineStuff);

		for (i in 0...12){
			var stupidLine:FlxSprite = new FlxSprite(208, 287.1);
			stupidLine.makeGraphic(10, Std.int(145.9), FlxColor.WHITE);
			stupidLine.ID = i;

			switch (i)
			{
				case 1:
					// rectangle
					stupidLine.x = 208;
					stupidLine.y = 278.1;
					stupidLine.makeGraphic(864, 10, FlxColor.WHITE);
				case 2:
					stupidLine.x = 208;
					stupidLine.y = 277.1 + 155;
					stupidLine.makeGraphic(864, 10, FlxColor.WHITE);
				case 3:
					stupidLine.x = 208 + 854;
					stupidLine.y = 287.1;
					stupidLine.makeGraphic(10, Std.int(145.9), FlxColor.WHITE);
				case 4:
					// up square
					stupidLine.x = 558.5;
					stupidLine.y = 36;
					stupidLine.makeGraphic(10, 144 + 10, FlxColor.WHITE);
				case 5:
					stupidLine.x = 558.5 + 153;
					stupidLine.y = 36 + 10;
					stupidLine.makeGraphic(10, 144 + 9, FlxColor.WHITE);
				case 6:
					stupidLine.x = 558.5 + 10;
					stupidLine.y = 36;
					stupidLine.makeGraphic(144 + 9, 10, FlxColor.WHITE);
				case 7:
					stupidLine.x = 558.5;
					stupidLine.y = 36 + 153;
					stupidLine.makeGraphic(144 + 10, 10, FlxColor.WHITE);
				case 8:
					// down square
					stupidLine.x = 558.5;
					stupidLine.y = 520.4;
					stupidLine.makeGraphic(10, 144 + 10, FlxColor.WHITE);
				case 9:
					stupidLine.x = 558.5 + 153;
					stupidLine.y = 520.4 + 10;
					stupidLine.makeGraphic(10, 144 + 9, FlxColor.WHITE);
				case 10:
					stupidLine.x = 558.5 + 10;
					stupidLine.y = 520.4;
					stupidLine.makeGraphic(144 + 9, 10, FlxColor.WHITE);
				case 11:
					stupidLine.x = 558.5;
					stupidLine.y = 520.4 + 153;
					stupidLine.makeGraphic(144 + 10, 10, FlxColor.WHITE);
			}
			lineStuff.add(stupidLine);
		}

		arrowItems = new FlxTypedGroup<FlxSprite>();
		add(arrowItems);

		for (i in 0...2)
		{
			var arrow:FlxSprite = new FlxSprite(square.x - 360, square.y + 10).loadGraphic(Paths.image('menustuff/redarrow', 'sadfox'));
			arrow.setGraphicSize(Std.int(arrow.width * 1.5));
			arrow.updateHitbox();
			arrow.antialiasing = false;
			arrow.ID = i;
			arrowItems.add(arrow);

			if (i == 1){
				arrow.x += 793;
				arrow.y += 496;
				arrow.flipY = true;
				FlxTween.tween(arrow, {y: arrow.y + 10}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
			}
			else FlxTween.tween(arrow, {y: arrow.y - 10}, 1, {ease: FlxEase.quadInOut, type: PINGPONG});
		}

		spikeThignies = new FlxTypedGroup<FlxSprite>();
		add(spikeThignies);

		for (i in 0...2)
		{
			var redshit:FlxSprite = new FlxSprite(-625, -36).loadGraphic(Paths.image('menustuff/main/spikes', 'sadfox'));
			redshit.setGraphicSize(Std.int(redshit.width * 1.1));
			redshit.updateHitbox();
			redshit.antialiasing = false;
			redshit.angle = 90;
			redshit.ID = i;
			spikeThignies.add(redshit);

			if (i == 1){
				redshit.angle += 180;
				redshit.x += 1122;
			}

			FlxTween.tween(redshit, {y: redshit.y + 36}, 4, {type: LOOPING, ease: FlxEase.linear});
		}

		yummy = new FlxSprite(0, 0).loadGraphic(Paths.image("menustuff/yummy", 'sadfox'));
		add(yummy);
		
		changeSelection();

   #if mobile
   addVirtualPad(UP_DOWN, A_B);
   addVirtualPadCamera(false);
   #end

		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if(FlxG.mouse.overlaps(yummy)){
			if(FlxG.mouse.justPressed){
				ClientPrefs.saveSettings();
				FlxFlicker.flicker(yummy, 1, 0.05, false, false, function(flick:FlxFlicker)
				{
					var poop:String = Highscore.formatSong('octane', 1);
	
					PlayState.SONG = Song.loadFromJson('octane', 'octane');
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = 1;

					LoadingState.loadAndSwitchState(new PlayState());
				});
			}
		}
			
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		statiCazzo.forEach(function(item:FlxSprite){
			item.alpha = FlxMath.lerp(0.3, item.alpha, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
		});
		
		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			var creditoLinko:String = creditsStuff[curSelected][3];
			if(controls.ACCEPT && (creditoLinko == null || creditoLinko.length > 4)) {
				if (!creditoLinko.startsWith('http'))
					MusicBeatState.switchState(new PsychCreditsState());
				else
					CoolUtil.browserLoad(creditoLinko);
			}
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}

		super.update(elapsed);
	}
	
	var lerpVal:Float = 1.2;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('interference'), 0.4);
		do {
			curSelected += change;
			lessSelected = (curSelected - 1);
			succSelected = (curSelected + 1);
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
			if (lessSelected == 0)
				lessSelected = creditsStuff.length - 1;
			if (lessSelected == -2)
				lessSelected = creditsStuff.length - 2;
			if (succSelected >= creditsStuff.length)
				succSelected = 1;
			if (succSelected == 0)
				succSelected = 1;
		} while(unselectableCheck(curSelected));

		statiCazzo.forEach(function(item:FlxSprite){
			item.alpha = 1;
		});

		optionText.text = creditsStuff[curSelected][0];
		descText.text = creditsStuff[curSelected][2];
		roleText.text = creditsStuff[curSelected][4];
		optionText.x = 386;
		roleText.x = optionText.width + 400;
		descText.x = optionText.x;
		
		// yeah i could use Paths but idc
		var pattolo:Array<String> = ['assets/images/credits/' + '${creditsStuff[curSelected][1]}' + '.png',
			'assets/images/credits/' + '${creditsStuff[lessSelected][1]}' + '.png',
			'assets/images/credits/' + '${creditsStuff[succSelected][1]}' + '.png'
		];
		for (i in 0...pattolo.length)
		{
			if(!Assets.exists(pattolo[i]))
			{
				trace('doesnt exist');
				pattolo[i] = 'assets/images/credits/error.png';
			}
		}
		icon.loadGraphic(pattolo[0]);
		precIcon.loadGraphic(pattolo[1]);
		succIcon.loadGraphic(pattolo[2]);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}