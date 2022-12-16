//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
#define time iTime
//SHADERTOY PORT FIX

const int MAX_STEPS = 64;
const float MIN_DIST = 0.0;
const float MAX_DIST = 100.0;
const float EPSILON = 1e-6;

//https://www.shadertoy.com/view/3s3GDn
float getGlow(float dist, float radius, float intensity){
	return pow(radius / max(dist, 1e-6), intensity);	
}


//----------------------------- Camera ------------------------------

vec3 rayDirection(float fieldOfView, vec2 fragCoord) {
    vec2 xy = fragCoord - iResolution.xy / 2.0;
    float z = (0.5 * iResolution.y) / tan(radians(fieldOfView) / 2.0);
    return normalize(vec3(xy, -z));
}

//https://www.geertarien.com/blog/2017/07/30/breakdown-of-the-lookAt-function-in-OpenGL/
mat3 lookAt(vec3 camera, vec3 targetDir, vec3 up){
    vec3 zaxis = normalize(targetDir);    
    vec3 xaxis = normalize(cross(zaxis, up));
    vec3 yaxis = cross(xaxis, zaxis);

    return mat3(xaxis, yaxis, -zaxis);
}


//-------------------------- SDF and scene ---------------------------

vec3 rotate(vec3 p, vec4 q){
  return 2.0 * cross(q.xyz, p * q.w + cross(q.xyz, p)) + p;
}

//https://iquilezles.org/articles/distfunctions
float torusSDF( vec3 p, vec2 t ){
  vec2 q = vec2(length(p.xz) - t.x, p.y);
  return length(q) - t.y;
}

float getSDF(vec3 position) {
   	float angle = iTime;
    vec3 axis = normalize(vec3(1.0, 1.0, 1.0));
    position = rotate(position, vec4(axis * sin(-angle*0.5), cos(-angle*0.5))); 
    return torusSDF(position, vec2(1.0, 0.2));

}


//---------------------------- Raymarching ----------------------------

// Glow variable is passed in by reference using the keyword inout. The result written in this
// function can be read afterwards from where it was called.
float distanceToScene(vec3 cameraPos, vec3 rayDir, float start, float end, inout float glow) {
	
    // Start at a predefined distance from the camera in the ray direction
    float depth = start;
    
    // Variable that tracks the distance to the scene at the current ray endpoint
    float dist;
    
    // For a set number of steps
    for (int i = 0; i < MAX_STEPS; i++) {
        
        // Get the SDF value at the ray endpoint, giving the maximum 
        // safe distance we can travel in any direction without hitting a surface
        dist = getSDF(cameraPos + depth * rayDir);
        
        // Calculate the glow at the current distance using the distance based glow function
        // Accumulate this value over the whole view ray
        // The smaller the step size, the smoother the final result
        glow += getGlow(dist, 1e-3, 0.55);
        
        // If the distance is small enough, we have hit a surface
        // Return the depth that the ray travelled through the scene
        if(dist < EPSILON){
            return depth;
        }
        
        // Else, march the ray by the sdf value
        depth += dist;
        
        // Test if we have left the scene
        if(depth >= end){
            return end;
        }
    }
    
    // Return max value if we hit nothing but remain in the scene after max steps
    return end;
}


//----------------------- Tonemapping and render ------------------------

//https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
vec3 ACESFilm(vec3 x){
    return clamp((x * (2.51 * x + 0.03)) / (x * (2.43 * x + 0.59) + 0.14), 0.0, 1.0);
}

void mainImage(){

    // Get the default direction of the ray (along the negative Z direction)
    vec3 rayDir = rayDirection(70.0, fragCoord);
    
    //----------------- Define a camera -----------------

    vec3 cameraPos = vec3(2.0);
    
    vec3 target = -normalize(cameraPos);
    vec3 up = vec3(0.0, 1.0, 0.0);
    
    // Get the view matrix from the camera orientation
    mat3 viewMatrix = lookAt(cameraPos, target, up);
    
    //---------------------------------------------------

    // Transform the ray to point in the correct direction
    rayDir = viewMatrix * rayDir;

    // Initialize glow to 0
    float glow = 0.0;
    
    // Find the distance to where the ray stops, pass in the glow variable to be accumulated
    float dist = distanceToScene(cameraPos, rayDir, MIN_DIST, MAX_DIST, glow);
    
    // Dist can now be used to render surfaces in the scene. We will only render the glow
  
    vec3 glowColour = vec3(0.2, 0.5, 1.0);
    
    // Glow now holds the value from the ray marching
    vec3 col = glow * glowColour;

    // Tonemapping
    col = ACESFilm(col);

    // Gamma
    col = pow(col, vec3(0.4545));
        
    fragColor = vec4(col, 1.0) + texture(iChannel0,uv);
}