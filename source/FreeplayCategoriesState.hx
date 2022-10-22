package;

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
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;

using StringTools;

class FreeplayCategoriesState extends MusicBeatState
{
    public var categories:Array<String> = ['main', 'side', 'extra'];

    var menuItems:FlxTypedGroup<FlxSprite>;
    private var camGame:FlxCamera;
    public static var curSelected:Int = 0;

    public var bg:FlxSprite;
    var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

    var camFollow:FlxObject;

    override function create()
    {
        camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

        bg = new FlxSprite(0, 0).loadGraphic(Paths.image("menustuff/bgDarkened", 'sadfox'));
		bg.setGraphicSize(Std.int(bg.width * 1.12));
		bg.screenCenter();
		bg.antialiasing = false;
		add(bg);

        camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

        for (i in 0...categories.length)
        {
            var item:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("menustuff/rings/" + categories[i].toLowerCase(), 'sadfox'));
            item.setGraphicSize(Std.int(item.width * 0.8));
            item.updateHitbox();
			item.screenCenter();
            item.antialiasing = true;
            //item.x = spikyThing.getGraphicMidpoint().x - item.width / 2;
            menuItems.add(item);
            item.ID = i;
        }

        leftArrow = new FlxSprite().loadGraphic(Paths.image("menustuff/main/arrow", 'sadfox'));
        leftArrow.y = 270;
        leftArrow.x = 0;

        rightArrow = new FlxSprite().loadGraphic(Paths.image("menustuff/main/arrow", 'sadfox'));
        rightArrow.y = 270;
        rightArrow.x = 1150;
        rightArrow.flipX = true;

        add(leftArrow);
        add(rightArrow);

		super.create();
    }

    var selectedSomethin:Bool = false;
	var lerpVal:Float = 0.2;

    override function update(elapsed:Float)
    {
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
                MusicBeatState.switchState(new MainMenuState());
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
                curSelected = 0;
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('confirmMenu'));

                /*
                FlxTween.tween(FlxG.camera, {y: -900}, 0.9, {
                    ease: FlxEase.quadInOut
                });
                */
                
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
                            var daChoice:String = categories[curSelected];
                            MusicBeatState.switchState(new FreeplayState());
                        });
                    }
                });
            }
        }

        super.update(elapsed);

        menuItems.forEach(function(item:FlxSprite)
        {
            if(item.ID == curSelected)
                item.alpha = CoolUtil.coolLerp(item.alpha, 1, lerpVal);
            else
                item.alpha = CoolUtil.coolLerp(item.alpha, 0, lerpVal);
        });
    }

    var lastCurSelected:Int = 0;

    function changeItem(val:Int = 0)
    {
        curSelected += val;

        if (curSelected >= categories.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = categories.length - 1;
    }
    
}