package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class NoteComboPopup extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);

		preloadStuff();
	}

	public function preloadStuff() {
		frames = Paths.getSparrowAtlas('noteCombo');
		antialiasing = ClientPrefs.globalAntialiasing;
		animation.addByPrefix('pop', 'note combo!', 24, false);
		alpha = 0;
	}

	public function comboHit() {
		alpha = 1;
		animation.play('pop', false);
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}