package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.FlxSprite;

class ExeSubstate extends MusicBeatSubstate
{
    var spookyMusic:FlxSound;
    var exe:FlxSprite;
    var isStarted:Bool = false;
    var isEnding:Bool = false;

    public function new(x:Float, y:Float)
    {
        super();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		add(bg);

		exe = new FlxSprite(0, 0).loadGraphic(Paths.image("head", 'sadfox'));
        exe.screenCenter(X);
        exe.screenCenter(Y);
        exe.alpha = 0;
		add(exe);

        FlxG.sound.play(Paths.sound("kefka"));

        spookyMusic = new FlxSound();
        spookyMusic.loadEmbedded(Paths.music("gameOver"), true, true);

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

        startDeath();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if(isStarted)
        {
            if (controls.ACCEPT)
            {
                backToPS();
            }
    
            if (controls.BACK)
            {
                spookyMusic.destroy();
                PlayState.deathCounter = 0;
                PlayState.seenCutscene = false;
                PlayState.chartingMode = false;
    
                WeekData.loadTheFirstEnabledMod();
                if (PlayState.isStoryMode)
                    MusicBeatState.switchState(new StoryMenuState());
                else
                    MusicBeatState.switchState(new FreeplayState());
    
                FlxG.sound.playMusic(Paths.music('freakyMenu'));
                PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
            }
        }
    }

    function startDeath()
    {
        new FlxTimer().start(1.8, function(tmr:FlxTimer)
        {
            isStarted = true;
            spookyMusic.play(false, 1);
            FlxTween.tween(exe, {alpha: 0.7}, 4);
        });
    }

    function backToPS()
    {		
        if (!isEnding)
		{
			isEnding = true;
            spookyMusic.destroy();
            FlxG.sound.play(Paths.music("confirmMenu"));

			new FlxTimer().start(0.7, function(tmr:FlxTimer)
            {
                FlxTween.tween(exe, {alpha: 0}, 2, {onComplete: function(twn:FlxTween){
                    MusicBeatState.resetState();
                }});
            });
        }
    }
}