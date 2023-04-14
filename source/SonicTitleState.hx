package;

#if desktop
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class SonicTitleState extends MusicBeatState
{
	var whiteScreen:FlxSprite;
	var segaIntro:FlxSprite;
	var bgIsle:FlxSprite;
	var copyright:FlxSprite;
	var logo0:FlxSprite;
	var logo1:FlxSprite;
	var sonec:FlxSprite;
	var code:FlxSprite;
	
	override public function create():Void
	{
		whiteScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		whiteScreen.screenCenter();
		add(whiteScreen);
		
		segaIntro = new FlxSprite(0, 0).loadGraphic(Paths.image("title/sega_intro"), true, 320, 73, false);
		segaIntro.animation.add("sega", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43], 30, false);
		segaIntro.setGraphicSize(Std.int(segaIntro.width * 4));
		segaIntro.updateHitbox();
		segaIntro.screenCenter();
		segaIntro.scrollFactor.set(0, 0);
		segaIntro.antialiasing = false;
		segaIntro.alpha = 0;
		add(segaIntro);

		bgIsle = new FlxSprite(0, 0).loadGraphic(Paths.image("title/island_bg"));
		bgIsle.setGraphicSize(FlxG.width);
		bgIsle.updateHitbox();
		bgIsle.screenCenter();
		bgIsle.scrollFactor.set(0, 0);
		bgIsle.antialiasing = false;
		bgIsle.alpha = 0;
		add(bgIsle);

		logo0 = new FlxSprite(0, 0).loadGraphic(Paths.image("title/logo_sonic0"));
		logo0.setGraphicSize(Std.int(logo0.width * 3.7));
		logo0.updateHitbox();
		logo0.screenCenter();
		logo0.scrollFactor.set(0, 0);
		logo0.antialiasing = false;
		logo0.alpha = 0;
		add(logo0);

		sonec = new FlxSprite(FlxG.width * 0.5 - 34, 63).loadGraphic(Paths.image("title/sonic_title"), true, 80, 80, false);
		sonec.animation.add("normal", [0, 0, 1, 1, 2, 2, 3, 3, 4, 4], 12, false);
		sonec.animation.add("exe", [5], 30, false);
		sonec.setGraphicSize(Std.int(sonec.width * 3.7));
		sonec.updateHitbox();
		sonec.scrollFactor.set(0, 0);
		sonec.antialiasing = false;
		sonec.alpha = 0;
		add(sonec);

		code = new FlxSprite(FlxG.width * 0.3 - 47, 92).loadGraphic(Paths.image("title/tails_title"), true, 96, 72, false);
		code.animation.add("normal", [0, 0, 1, 1, 2, 2, 3, 3, 4, 4], 12, false);
		code.animation.add("exe", [5], 30, false);
		code.setGraphicSize(Std.int(code.width * 3.7));
		code.updateHitbox();
		code.scrollFactor.set(0, 0);
		code.antialiasing = false;
		code.alpha = 0;
		add(code);

		logo1 = new FlxSprite(0, 0).loadGraphic(Paths.image("title/logo_sonic1"));
		logo1.setGraphicSize(Std.int(logo1.width * 3.7));
		logo1.updateHitbox();
		logo1.screenCenter();
		logo1.scrollFactor.set(0, 0);
		logo1.antialiasing = false;
		logo1.alpha = 0;
		add(logo1);

		copyright = new FlxSprite(FlxG.width * 0.74, FlxG.height * 0.95).loadGraphic(Paths.image("title/sega_copyright"), true, 88, 8, false);
		copyright.animation.add("sega", [0], 24, false);
		copyright.animation.add("god", [1], 24, false);
		copyright.animation.play("sega");
		copyright.setGraphicSize(Std.int(copyright.width * 3.7));
		copyright.updateHitbox();
		copyright.scrollFactor.set(0, 0);
		copyright.antialiasing = false;
		copyright.alpha = 0;
		add(copyright);

		new FlxTimer().start(1, function(blo:FlxTimer)
		{
			segaIntro.alpha = 1;
			segaIntro.animation.play("sega");
			segaIntro.animation.finishCallback = function(robo:String)
			{
				FlxG.sound.play(Paths.sound('sega'));
				new FlxTimer().start(4, function(tmr:FlxTimer)
				{
					startIntro();
				});
			}
		});
		
		super.create();
	}

	function startIntro():Void
	{
		FlxTween.tween(segaIntro, {alpha: 0}, 0.1, {ease: FlxEase.linear});
		FlxTween.tween(whiteScreen, {alpha: 0}, 0.5, {
			ease: FlxEase.linear,
			onComplete: function(twn:FlxTween)
			{
				segaIntro.destroy();
				whiteScreen.destroy();
				var presents:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("title/presentation"));
				presents.setGraphicSize(Std.int(segaIntro.width * 0.7));
				presents.updateHitbox();
				presents.screenCenter();
				presents.scrollFactor.set(0, 0);
				presents.antialiasing = false;
				presents.alpha = 0;
				add(presents);

				FlxTween.tween(presents, {alpha: 1}, 0.5, {
					ease: FlxEase.linear,
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(presents, {alpha: 0}, 0.5, {ease: FlxEase.linear,
							startDelay: 3,
							onComplete: function(twn:FlxTween)
							{
								shitAppears();
							}
						});
					}
				});
			}
		});
	}

	function shitAppears():Void
	{
		FlxG.sound.playMusic(Paths.music('sonic2menu'));
		starsAppear();
		
		FlxTween.tween(logo0, {alpha: 1}, 0.5, {ease: FlxEase.linear, startDelay: 1.34});
		FlxTween.tween(logo1, {alpha: 1}, 0.5, {ease: FlxEase.linear, startDelay: 1.34});
		FlxTween.tween(copyright, {alpha: 1}, 1, {ease: FlxEase.linear, startDelay: 2.31});
		FlxTween.tween(bgIsle, {alpha: 1}, 0.01, {ease: FlxEase.linear, startDelay: 4.31});

		new FlxTimer().start(2.31, Palle, 0);
		new FlxTimer().start(4.31, function(tmr:FlxTimer){
			FlxG.camera.flash(FlxColor.WHITE, 0.6);
		});
	}

	function starsAppear():Void
	{
		starAppear(0, FlxG.width * 0.45, FlxG.height * 0.1);
		starAppear(0.65, FlxG.width * 0.32, FlxG.height * 0.55);
		starAppear(0.96, FlxG.width * 0.6, FlxG.height * 0.53);
		starAppear(1.34, FlxG.width * 0.53, FlxG.height * 0.78);
		starAppear(1.56, FlxG.width * 0.8, FlxG.height * 0.27);
		starAppear(1.81, FlxG.width * 0.3, FlxG.height * 0.37);
		starAppear(2.06, FlxG.width * 0.41, FlxG.height * 0.57);
		starAppear(2.23, FlxG.width * 0.7, FlxG.height * 0.37);
		starAppear(2.56, FlxG.width * 0.47, FlxG.height * 0.78);
		starAppear(2.81, FlxG.width * 0.34, FlxG.height * 0.7);
		starAppear(3.06, FlxG.width * 0.71, FlxG.height * 0.58);
	}

	private var delirio:Bool = false;
	override function update(elapsed:Float)
	{
		if (delirio)
		{
			bgIsle.alpha = FlxG.random.float(0, 1);
			copyright.animation.play("god");
			logo0.setPosition(FlxG.random.float(FlxG.width * 0.01, 1173), FlxG.random.float(FlxG.height * 0.01, FlxG.height * 0.9));
			logo1.setPosition(FlxG.random.float(FlxG.width * 0.01, 1173), FlxG.random.float(FlxG.height * 0.01, FlxG.height * 0.9));
			sonec.setPosition(FlxG.random.float(FlxG.width * 0.01 - 34, FlxG.width * 0.9 - 34), FlxG.random.float(0, FlxG.height - 63));
			code.setPosition(FlxG.random.float(FlxG.width * 0.01 - 47, FlxG.width * 0.9 - 47), FlxG.random.float(0, FlxG.height - 92));
			sonec.animation.play("exe");
			code.animation.play("exe");
		}
		
		super.update(elapsed);
	}

	private function starAppear(timeLol:Float, ascissa:Float, ordinata:Float)
	{
		new FlxTimer().start(timeLol, function(tmr:FlxTimer)
		{
			var star1:FlxSprite = new FlxSprite(ascissa, ordinata).loadGraphic(Paths.image("title/particles"), true, 23, 23, false);
			star1.animation.add("twink", [0, 1, 2, 3, 4, 3, 2, 1, 0], 30, false);
			star1.animation.play("twink");
			star1.setGraphicSize(Std.int(star1.width * 4));
			star1.updateHitbox();
			star1.scrollFactor.set(0, 0);
			star1.antialiasing = false;
			add(star1);

			star1.animation.finishCallback = function(robo:String)
			{
				star1.kill();
			}
		});
	}

	private static var coglionata:Int = 0;
	private function Palle(tmr:FlxTimer)
	{
		switch (coglionata)
		{
			case 0:
				sonec.animation.play("normal");
				sonec.alpha = 1;
				coglionata++;
				tmr.reset(1.05); // 3.36
			case 1:
				code.animation.play("normal");
				code.alpha = 1;
				coglionata++;
				tmr.reset(4.44); // 7.8
			case 2:
				delirio = true;
				coglionata++;
				tmr.reset(1);
			case 3:
				coglionata++;
				FlxG.sound.music.stop();
				FlxG.save.data.watchedSegaIntroShitSonic = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				MusicBeatState.switchState(new TitleState());
		}
	}
}
