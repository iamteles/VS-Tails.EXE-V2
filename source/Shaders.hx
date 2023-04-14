package;

import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import flixel.FlxG;

class Shaders
{
	// i totally didnt steal it from Tr1Ngle Engine :troll:
	
	public static var chromaticAberration:ShaderFilter = new ShaderFilter(new ChromaticAberration());
	public static var vcrDistortLol:ShaderFilter = new ShaderFilter(new VCRDistortion());

	public static function setChrome(?chromeOffset:Float):Void
	{
		chromaticAberration.shader.data.rOffset.value = [chromeOffset];
		chromaticAberration.shader.data.gOffset.value = [0.0];
		chromaticAberration.shader.data.bOffset.value = [chromeOffset * -1];
	}
}