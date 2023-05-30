#pragma header
//https://github.com/bbpanzu/FNF-Sunday/blob/main/source_sunday/RadialBlur.hx
//https://www.shadertoy.com/view/XsfSDs
	uniform float cx = 0.5; //center x (0.0 - 1.0)
	uniform float cy = 0.5; //center y (0.0 - 1.0)
    uniform float blurWidth = 0.3; // blurAmount 
	
	const int nsamples = 30; //samples
	
	void main(){
		vec4 color = texture2D(bitmap, openfl_TextureCoordv);
			vec2 res;
			res = openfl_TextureCoordv;
		vec2 pp;
		pp = vec2(cx, cy);
		vec2 center = pp;
		float blurStart = 1.0;

		
		vec2 uv = openfl_TextureCoordv.xy;
		
		uv -= center;
		float precompute = blurWidth * (1.0 / float(nsamples - 1));
		
		for(int i = 0; i < nsamples; i++)
		{
			float scale = blurStart + (float(i)* precompute);
		color += texture2D(bitmap, uv * scale + center);
		}
		
		
		color /= float(nsamples);
		
		gl_FragColor = color; 
	
	}