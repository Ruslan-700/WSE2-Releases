
#if defined PS_3
#if FXAA
#define FXAA_PC 1
#define FXAA_HLSL_3 1
#if FXAA == 1
#define FXAA_QUALITY__PRESET 12
#elif FXAA == 2
#define FXAA_QUALITY__PRESET 22
#elif FXAA == 3
#define FXAA_QUALITY__PRESET 26
#endif
#define FXAA_GREEN_AS_LUMA 1
#include "Fxaa3_11.h"
#endif

#define PreSharpenHighQuality true
#define PreSharpenBlurFactor 2.0
#define PreSharpenAverageFactor 0.6
#define PreSharpenOriginalFactor (1 + PreSharpenBlurFactor)
#define PreSharpenEdgeFactor 0.2
#define PreSharpenVal0 1.0
#define PreSharpenVal1 ((PreSharpenVal0 - 1) / 8.0)

#define px g_HalfPixel_ViewportSizeInv.z
#define py g_HalfPixel_ViewportSizeInv.w
#define dx (PreSharpenAverageFactor * px)
#define dy (PreSharpenAverageFactor * py)

float4 PreSharpenPass(float4 ori, float2 tex)
{
	float4 c1 = tex2D(postFX_sampler0, tex + float2(-dx, -dy));
	float4 c2 = tex2D(postFX_sampler0, tex + float2(0, -dy));
	float4 c3 = tex2D(postFX_sampler0, tex + float2(dx, -dy));
	float4 c4 = tex2D(postFX_sampler0, tex + float2(-dx, 0));
	float4 c5 = tex2D(postFX_sampler0, tex + float2(dx, 0));
	float4 c6 = tex2D(postFX_sampler0, tex + float2(-dx, dy));
	float4 c7 = tex2D(postFX_sampler0, tex + float2(0, dy));
	float4 c8 = tex2D(postFX_sampler0, tex + float2(dx, dy));
	float4 blur = (c1 + c3 + c6 + c8 + 2 * (c2 + c4 + c5 + c7) + 4 * ori) * 0.0625;
	float4 cori = PreSharpenOriginalFactor * ori - PreSharpenBlurFactor * blur;
	
	if (PreSharpenHighQuality)
	{
		c1 = tex2D(postFX_sampler0, tex + float2(-px, -py));
		c2 = tex2D(postFX_sampler0, tex + float2(0, -py));
		c3 = tex2D(postFX_sampler0, tex + float2(px, -py));
		c4 = tex2D(postFX_sampler0, tex + float2(-px, 0));
		c5 = tex2D(postFX_sampler0, tex + float2(px, 0));
		c6 = tex2D(postFX_sampler0, tex + float2(-px, py));
		c7 = tex2D(postFX_sampler0, tex + float2(0, py));
		c8 = tex2D(postFX_sampler0, tex + float2(px, py));
	}
	
	float delta1 = (c3 + 2 * c5 + c8) - (c1 + 2 * c4 + c6);
	float delta2 = (c6 + 2 * c7 + c8) - (c1 + 2 * c2 + c3);
	
	if (sqrt(mul(delta1, delta1) + mul(delta2, delta2)) > PreSharpenEdgeFactor)
		return ori * PreSharpenVal0 - (c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8) * PreSharpenVal1;
	else
		return cori;
}

float4 PostSharpenPass(float4 orig, float2 tex, float factor)
{
	float4 color;
	
	color = 9.0 * orig;
	color -= tex2D(postFX_sampler0, tex.xy + float2(px, py));
	color -= tex2D(postFX_sampler0, tex.xy + float2(0, py));
	color -= tex2D(postFX_sampler0, tex.xy + float2(-px, py));
	color -= tex2D(postFX_sampler0, tex.xy + float2(-px, 0));
	color -= tex2D(postFX_sampler0, tex.xy + float2(-px, -py));
	color -= tex2D(postFX_sampler0, tex.xy + float2(0, -py));
	color -= tex2D(postFX_sampler0, tex.xy + float2(px, -py));
	color -= tex2D(postFX_sampler0, tex.xy + float2(px, 0));
	color = color * factor + (1.0 - factor) * orig;
	color.a = orig.a;
	return color;
}

#define TechniAmount 0.30
#define TechniPower 4.5

#define redfilter float4(0.8, 1.0, 0.8, 1.00)
#define greenfilter float4(0.30, 1.0, 0.0, 1.0)
#define bluefilter float4(0.25, 1.0, 1.0, 1.0)
#define redorangefilter float4(1.05, 0.620, 0.0, 1.0)
#define cyanfilter float4(0.0, 1.30, 1.0, 1.0)
#define magentafilter float4(1.0, 0.0, 1.05, 1.05)
#define yellowfilter float4(1.6, 1.6, 0.05, 1.0)

float4 TechnicolorPass(float4 colorInput, float2 tex)
{
	float4 tcol = colorInput;
	float4 filtgreen = tcol * greenfilter;
	float4 filtblue = tcol * magentafilter;
	float4 filtred = tcol * redorangefilter;
	float4 rednegative = float((filtred.r + filtred.g + filtred.b) / TechniPower);
	float4 greennegative = float((filtgreen.r + filtgreen.g + filtgreen.b) / TechniPower);
	float4 bluenegative = float((filtblue.r + filtblue.g + filtblue.b) / TechniPower);
	float4 redoutput = rednegative + cyanfilter;
	float4 greenoutput = greennegative + magentafilter;
	float4 blueoutput = bluenegative + yellowfilter;
	float4 result = redoutput * greenoutput * blueoutput;
	
	return lerp(tcol, result, TechniAmount);
}

#define Gamma 1.02
#define Exposure -0.05
#define Saturation 0.35

float4 TonemapPass(float4 colorInput, float2 tex)
{
	float4 color = colorInput;
	
	color *= pow(2.0f, Exposure);
	color = pow(color, Gamma);
	float3 lumCoeff = float3(0.299, 0.587, 0.114);
	float lum = dot (lumCoeff, color.rgb);
	float3 blend = lum.rrr;
	float L = min(1, max (0, 10 * (lum - 0.45)));
	float3 result1 = 2.0f * color.rgb * blend;
	float3 result2 = 1.0f - 2.0f * (1.0f - blend) * (1.0f - color.rgb);
	float3 newColor = lerp(result1, result2, L);
	float4 middlegray = float(color.r + color.g + color.b) / 3;
	float4 diffcolor = color - middlegray;
	color = (color + diffcolor * Saturation) / (1 + (diffcolor * Saturation));
	return color;
}

VS_OUT_POSTFX vs_main_postFX_postprocess(float4 pos: POSITION)
{
	VS_OUT_POSTFX Out;
	
	Out.Pos = pos;
	Out.Tex = (float2(pos.x, -pos.y) * 0.5f + 0.5f) + g_HalfPixel_ViewportSizeInv.xy;
	
	return Out;
}

VertexShader postprocess_vertex_shader = compile vs_3_0 vs_main_postFX_postprocess();

float4 ps_main_postFX_postprocess(float2 texCoord: TEXCOORD0) : COLOR
{
	float4 tex;
	
#if FXAA
	float qualityEdgeThreshold;
#if FXAA == 1
	qualityEdgeThreshold = 0.250f;
#elif FXAA == 2
	qualityEdgeThreshold = 0.166f;
#elif FXAA == 3
	qualityEdgeThreshold = 0.125f;
#endif
	tex = FxaaPixelShader(texCoord, 0, postFX_sampler0, postFX_sampler0, postFX_sampler0, g_HalfPixel_ViewportSizeInv.zw, 0, 0, 0, 0.75f, qualityEdgeThreshold, 0.0f, 0, 0, 0, 0);
#else
	tex = tex2D(postFX_sampler0, texCoord);
#endif
	
#if POSTPROCESS > 1
	tex = PreSharpenPass(tex, texCoord);
#endif
	
#if POSTPROCESS > 2
	tex = TechnicolorPass(tex, texCoord);
	tex = TonemapPass(tex, texCoord);
#endif
	
#if POSTPROCESS > 1
	tex = PostSharpenPass(tex, texCoord, 0.03f);
#elif POSTPROCESS == 1
	tex = PostSharpenPass(tex, texCoord, 0.04f);
#endif
	
	tex.w = 1;
	return saturate(tex);
}

technique postFX_postprocess { pass P0 { VertexShader = postprocess_vertex_shader; PixelShader = compile ps_3_0 ps_main_postFX_postprocess(); } }

////////////////////////////////////////////////////////////////////////////////////
// Screen space ambient occlusion.
//
// Self contained on purpose. These are the engine's own passes, named and looked up by it,
// so a module's postFX.fx gets occlusion from the include alone and none of the techniques
// it wrote itself have to change. The engine resolves the names once and leaves the whole
// chain out when they are missing, so an older postFX simply draws without occlusion.
//
// Depth here is linear - the scene writes Out.Pos.z * far_clip_Inv - so a view space
// position is one multiply, with no projection matrix to invert. Normals are not available
// at all and come from the derivatives of that position: that is what makes this depth
// only, and it is why the result is faceted on curved surfaces and haloes across
// silhouettes. The blur below is what makes that bearable.
#if PS_3

float4 g_SSAO_Projection;	// xy: tan(fov/2) per axis, zw: far - near, and near
float4 g_SSAO_Settings;		// x: radius in metres, y: strength, z: fog density, w: unused
// The water surface as a plane, in the terms this pass works in: xyz turn a view space
// position into its height above that plane, w being the camera's own height above it.
//
// The surface is NOT in the depth target - the foam and the refraction need what lies behind
// it - so without this the occlusion worked out for a submerged bottom is drawn into a pixel
// that shows the water over it, and drawn as crisply as if the water were not there.
//
// All zero is a scene with no water: the camera and every sample then sit exactly on the
// plane, nothing is ever crossed, and the term stays at one.
float4 g_SSAO_Water;
// The medium in front of the surface, so the occlusion can be kept off its share of the pixel
// rather than darkening it along with the surface it belongs to.
float4 g_SSAO_FogColor;
// The height term of the fog, which the forward pass folds into the distance and this pass
// has to fold into it the same way or the two describe different air.
//
// x is one over the falloff and y the strength, with zero meaning the scene has none: the
// multiplier is then exactly one and every frame without height fog comes back bit for bit.
//
// Initialised rather than left to the effect, so that an exe older than this file - one that
// never looks the parameter up at all - gets that multiplier of one as well.
float4 g_SSAO_HeightFog = float4(0.0f, 0.0f, 0.0f, 0.0f);
// Where a view space position stands in the height the term above is measured in: xyz are the
// world z of the three view axes and w the camera's own height above the fog's base. Same
// construction as g_SSAO_Water, and for the same reason - this pass knows view space and the
// fog is a statement about world height.
float4 g_SSAO_HeightFogAxes = float4(0.0f, 0.0f, 0.0f, 0.0f);
// The three powers the forward pass raises the fog factor to, and in w whether it does.
// Under water that pass takes the colours out in order rather than greying the view, and
// the share of the pixel the medium owns is therefore a different fraction in each
// channel - at the measured 3.02, 1.43 and 1.00 and a factor of a half it is .877, .629
// and .500, where one grey factor says .500 for all three and hands the occlusion red the
// frame has already taken away.
//
// Blended rather than branched, exactly as the forward pass blends it and for the same
// reason: a flattened branch would hand every dry pixel pow(x, 1), which is the identity
// in arithmetic and not in the last bit of a log and an exponential. With the flag down
// the factor comes back untouched, so every scene above water is bit for bit what it was.
float4 g_SSAO_FogTint = float4(1.0f, 1.0f, 1.0f, 0.0f);

// How many times thicker the air is at this position than the density alone says. The forward
// pass writes this as 1 + strength * exp2(-max(wz - base, 0) / falloff) and folds it into the
// distance, which is the same as scaling the density by it; the expression is copied rather
// than approximated, because a fade that disagrees with the fog is the whole defect.
float ssao_height_fog_thickening(float3 P)
{
	float above = dot(P, g_SSAO_HeightFogAxes.xyz) + g_SSAO_HeightFogAxes.w;

	return 1.0f + g_SSAO_HeightFog.y * exp2(-max(above, 0.0f) * g_SSAO_HeightFog.x);
}

// How far the sampling disc may reach in texture coordinates, whatever the radius in metres
// works out to. It grows as one over the distance, so close to a wall a half metre is
// already a sixth of the screen, and eight samples spread over that are a hundred pixels
// apart - blotches, not occlusion, and too coarse for the blur to rescue. Past this the
// occlusion simply stops growing, which is what every implementation does.
static const float SSAO_MAX_SCREEN_RADIUS = 0.035f;

// And how small it is allowed to get at the other end. Past the far threshold the disc
// is wide enough for its samples to land on different texels and mean something; below
// the near one they all land on the same few, and what comes back is the quantisation of
// the depth target read as shading. In texels of this pass, which is half the width of
// the screen. At a half metre radius and a sixty degree field that is roughly seventy
// metres to two hundred - and past two hundred the samples are not taken at all.
static const float SSAO_FULL_TEXELS = 6.0f;
static const float SSAO_MIN_TEXELS = 2.0f;

// A golden angle spiral: any prefix of it is still spread evenly, so the eight sample
// technique can use the first half of the same table without clumping.
static const float2 SSAO_KERNEL[16] =
{
	float2( 0.17678f,  0.00000f), float2(-0.22577f,  0.20683f),
	float2( 0.03456f, -0.39377f), float2( 0.28457f,  0.37117f),
	float2(-0.52222f, -0.09237f), float2( 0.49470f, -0.31468f),
	float2(-0.16547f,  0.61553f), float2(-0.31556f, -0.60759f),
	float2( 0.68464f,  0.25003f), float2(-0.71226f,  0.29401f),
	float2( 0.34335f, -0.73373f), float2( 0.25373f,  0.80893f),
	float2(-0.76475f, -0.44319f), float2( 0.89713f, -0.19723f),
	float2(-0.54751f,  0.77877f), float2(-0.12649f, -0.97609f),
};

// The scene writes Out.Pos.z * far_clip_Inv through a right handed projection, which works
// out as (distance - near) / (far - near). That is affine in the view position, so the
// interpolator reproduces it exactly and it is linear in distance along the view axis.
// Undoing it is one mad, and what comes out is a position in metres in a space whose z
// points forward - self consistent, which is all the occlusion test asks for.
//
// tex2Dlod rather than tex2D: the depth target carries no mip levels, so the two fetch the
// same texel, and the explicit level keeps the rotated kernel from asking for a gradient
// that would mean nothing.
// Returns the position in xyz and the depth it came from in w. The depth is wanted raw as
// well, because zero there means nothing was ever drawn - the sky - and a position worked
// out from it would sit at the near plane, right in front of the camera, which is the most
// convincing occluder imaginable and entirely fictional.
float4 ssao_view_sample(float2 tex)
{
	float depth = tex2Dlod(postFX_sampler0, float4(tex, 0.0f, 0.0f)).r;
	float distance = depth * g_SSAO_Projection.z + g_SSAO_Projection.w;
	float2 ndc = float2(tex.x * 2.0f - 1.0f, 1.0f - tex.y * 2.0f);

	return float4(float3(ndc.x * g_SSAO_Projection.x, ndc.y * g_SSAO_Projection.y, 1.0f) * distance, depth);
}

// numSamples is uniform const so each technique compiles its own unrolled copy. A loop
// counted by a constant register would be worse than slow: a pixel shader cannot address
// the kernel table relatively, so it would not compile at all.
float4 ps_main_postFX_ssao(uniform const int numSamples, float2 texCoord: TEXCOORD0) : COLOR
{
	float4 center = ssao_view_sample(texCoord);
	float3 P = center.xyz;

	// The sky never writes the depth target, so nothing here can be occluded.
	if (center.w <= 0.0001f)
		return 1.0f;

	// The normal used to come from ddx/ddy of the position. At a silhouette those straddle
	// the discontinuity and give a normal belonging to neither surface, which is what drew a
	// dark fringe along a roof against the sky. Taking the four neighbours and keeping,
	// per axis, whichever side is closer in depth picks the side that is the same surface -
	// and a neighbour on the sky is far away in depth, so it loses by itself.
	float2 texel = g_HalfPixel_ViewportSizeInv.zw;
	float4 right = ssao_view_sample(texCoord + float2(texel.x, 0.0f));
	float4 left  = ssao_view_sample(texCoord - float2(texel.x, 0.0f));
	float4 down  = ssao_view_sample(texCoord + float2(0.0f, texel.y));
	float4 up    = ssao_view_sample(texCoord - float2(0.0f, texel.y));

	// Not dx and dy: this file already defines those as macros for the sharpen pass.
	float3 deltaX = abs(right.w - center.w) < abs(center.w - left.w) ? right.xyz - P : P - left.xyz;
	float3 deltaY = abs(down.w - center.w) < abs(center.w - up.w) ? down.xyz - P : P - up.xyz;

	// deltaX runs right across the screen and deltaY runs down it, and down the screen is
	// -y here, so this is the order that points the normal back at the camera.
	float3 N = normalize(cross(deltaX, deltaY));

	// The frustum is 2 * z * tan(fov/2) wide at this depth and that width is 1.0 in texture
	// coordinates, so the radius in metres becomes a radius in texture coordinates by
	// dividing by that. Close to the eye it has to be given up on: half a metre two metres
	// away covers a sixth of the screen, and twelve samples spread over that are a hundred
	// pixels apart, which is blotches rather than occlusion and far too coarse for the blur
	// to rescue.
	//
	// Giving it up is done to the radius in METRES, once, and smoothly. Clamping the texture
	// coordinate radius per axis instead - which is what stood here - fails twice over. The
	// two axes reach the limit at different depths, because the aspect ratio sits in the
	// tangents, so between those depths only x was clamped and the disc became an ellipse;
	// and the clamp itself is a kink, at a fixed distance from the eye. Both read on open
	// ground as a band of shading lying across the terrain at a set distance and sliding
	// over it as the camera turns.
	//
	// r * z / (z + nearLimit) has no kink anywhere, keeps the disc a disc, tends to the
	// configured radius with distance, and its texture coordinate radius is exactly
	// SSAO_MAX_SCREEN_RADIUS at the eye and falls from there - so the sample spacing that
	// the clamp existed to bound is still bounded.
	float nearLimit = g_SSAO_Settings.x / (2.0f * SSAO_MAX_SCREEN_RADIUS * g_SSAO_Projection.x);
	float worldRadius = g_SSAO_Settings.x * P.z / (P.z + nearLimit);
	float2 radius = worldRadius / (2.0f * P.z * g_SSAO_Projection.xy);

	// How far a sample may be before it counts as a different object rather than an
	// occluder. It follows the radius actually sampled at this pixel, not the configured
	// one: a fixed distance in metres against a radius that varies with depth is a second
	// way for the occlusion to change character partway up the ground.
	float reach = worldRadius * 3.0f;

	// Faded rather than cut, and the early out sits exactly where the fade reaches zero,
	// so the two agree and no line is drawn across the ground where one takes over from
	// the other. Distance is screen coherent, so the branch is taken by whole regions of
	// the frame at once, which is the case a pixel shader branch is actually good at.
	float fade = saturate((radius.x / g_HalfPixel_ViewportSizeInv.z - SSAO_MIN_TEXELS)
		/ (SSAO_FULL_TEXELS - SSAO_MIN_TEXELS));

	// And faded again by how much of this surface the fog lets through, because the
	// occlusion is multiplied into a colour that already has the fog in it. Without this
	// a crease on a surface the fog has whited out is still drawn at full strength: sharp
	// dark lines over geometry that is barely there. Under water it is unmissable - that
	// density washes the frame out within metres - but it is the same mistake in a thick
	// morning fog, only slower to notice.
	//
	// Exactly the fog's own curve, 1/exp2(d * density) against the ray distance, so the
	// shading fades at the rate the surface itself does rather than at one picked to look
	// right. length(P) rather than P.z for the same reason: the forward pass fogs by
	// length of the view space position, and at the edge of a wide field those differ by
	// enough to see. Density zero leaves the term at one, which is what an engine that
	// does not send it gets.
	fade *= exp2(-length(P) * g_SSAO_Settings.z * ssao_height_fog_thickening(P));

	// And stopped altogether where water lies between, which the term above cannot see: that
	// one fades by the medium the CAMERA is in, and a bottom under two metres of river is
	// hidden by water while the camera breathes air.
	//
	// A fade by the water's own density was tried first and was far too gentle to matter -
	// a metre of it leaves four fifths of the shading. The measurement that killed it also
	// said why: what is wrong with occlusion drawn through water is not how DARK it is but
	// how SHARP. The depth target holds no water surface - the foam and the refraction need
	// what lies behind it - so the creases come out as crisp as if the water were not there,
	// while everything else about that bottom is dimmed and smeared by it. Brightness cannot
	// fix sharpness.
	//
	// So it ramps out over half a metre: occlusion survives where the water is a film over
	// a wet stone and goes where it is a body of water. The same ramp covers the other
	// direction, a hull seen from below, because the ray crosses the same surface.
	//
	// The column is taken vertically rather than along the ray. At a grazing angle that
	// under-states the water crossed, which is the error worth having: it can only leave
	// occlusion in, never invent it.
	float sampleHeight = dot(P, g_SSAO_Water.xyz) + g_SSAO_Water.w;
	float crossed = max(0.0f, -min(g_SSAO_Water.w, sampleHeight))
		* step(g_SSAO_Water.w * sampleHeight, 0.0f);

	fade *= saturate(1.0f - crossed * 2.0f);

	// Both reasons to stop share the one early out, and the threshold is what the frame
	// can show rather than zero: below a 255th of full strength the darkening does not
	// exist in an eight bit channel. So there is still no line where it takes over, which
	// is the property the distance fade was built around and must not lose.
	if (fade <= 0.004f)
		return 1.0f;

	// Turning the kernel by a per pixel angle trades banding for noise, which the blur can
	// then do something about. Banding it could not.
	float angle = frac(sin(dot(texCoord, float2(12.9898f, 78.233f))) * 43758.5453f) * 6.2831853f;
	float2 rot = float2(cos(angle), sin(angle));

	float occlusion = 0.0f;

	// Unrolled on purpose. Left as a loop, a pixel shader cannot address the kernel
	// table relatively, so the compiler walks the whole table on every iteration instead.
	[unroll] for (int i = 0; i < numSamples; ++i)
	{
		float2 k = SSAO_KERNEL[i];
		float2 offset = float2(k.x * rot.x - k.y * rot.y, k.x * rot.y + k.y * rot.x) * radius;

		float4 sample = ssao_view_sample(texCoord + offset);
		float3 toSample = sample.xyz - P;
		float distance = length(toSample);

		// The cosine decides how much of the hemisphere the sample blocks; subtracting a
		// little keeps a flat surface from occluding itself through depth precision. The
		// second term drops samples too far away to be an occluder rather than a different
		// object altogether, which is what otherwise draws a dark halo around everything.
		// The third keeps the sky out of it: untouched depth is not a surface.
		// dot(N, v / d) written as dot(N, v) / d: the same number for three fewer multiplies,
		// which matters when it is paid for on every sample.
		occlusion += saturate(dot(N, toSample) / max(distance, 0.0001f) - 0.02f)
		           * saturate(1.0f - distance / reach)
		           * step(0.0001f, sample.w);
	}

	return saturate(1.0f - occlusion * g_SSAO_Settings.y * fade / numSamples);
}

// Separable, and weighted by depth so the occlusion does not bleed across a silhouette.
// The tolerance is relative because the depth is linear: a centimetre matters underfoot and
// is nothing at the far plane.
float4 ps_main_postFX_ssao_blur(uniform const float2 direction, float2 texCoord: TEXCOORD0) : COLOR
{
	float2 step = direction * g_HalfPixel_ViewportSizeInv.zw;
	float centerDepth = tex2D(postFX_sampler1, texCoord).r;

	float occlusion = 0.0f;
	float weightSum = 0.0f;

	[unroll] for (int i = -3; i <= 3; ++i)
	{
		float2 tex = texCoord + step * i;
		float depth = tex2D(postFX_sampler1, tex).r;
		float weight = saturate(1.0f - abs(depth - centerDepth) / (centerDepth * 0.05f + 0.0005f));

		occlusion += tex2D(postFX_sampler0, tex).r * weight;
		weightSum += weight;
	}

	return occlusion / max(weightSum, 0.0001f);
}

// The scene with occlusion folded in. The engine points its final pass at this instead of
// at the scene, which is the whole reason a module's own techniques need no edit.
float4 ps_main_postFX_ssao_apply(float2 texCoord: TEXCOORD0) : COLOR
{
	float4 color = tex2D(postFX_sampler0, texCoord);
	float occlusion = tex2D(postFX_sampler1, texCoord).r;

	// The occlusion belongs to the SURFACE, and this pixel is that surface seen through
	// whatever lies in front of it. Multiplying the whole pixel darkens the medium too,
	// which is wrong wherever the medium is brighter than the thing it hides - under water
	// above all, where a dark hull three metres off went on drawing its creases across a
	// washed out blue.
	//
	// So the medium's share is taken out, the occlusion applied to what is left, and the
	// share put back. Where the medium and the surface are of a brightness this comes to
	// the same thing as multiplying, which is why the simpler form stood until a bright
	// medium turned up. Density zero leaves no share at all and the two forms agree exactly.
	float depth = tex2D(postFX_sampler2, texCoord).r;
	float dist = depth * g_SSAO_Projection.z + g_SSAO_Projection.w;
	float2 ndc = float2(texCoord.x * 2.0f - 1.0f, 1.0f - texCoord.y * 2.0f);
	float3 P = float3(ndc.x * g_SSAO_Projection.x, ndc.y * g_SSAO_Projection.y, 1.0f) * dist;

	float visibility = exp2(-length(P) * g_SSAO_Settings.z * ssao_height_fog_thickening(P));
	float3 medium = g_SSAO_FogColor.rgb
		* (1.0f - lerp(visibility, pow(visibility, g_SSAO_FogTint.rgb), g_SSAO_FogTint.w));

	// And the medium may not be brighter than the pixel it is supposed to be part of.
	//
	// The depth read above belongs to whatever the depth pass drew, and that is not always
	// what the frame drew: a surface held out of the depth pass leaves the depth of the
	// BACKGROUND behind it standing in this pixel. Foliage is exactly that - it enters the
	// depth pass only where the effect declares the cutout threshold, so a module shipping
	// its own effect has none of it in there. The share then comes out for a distance much
	// greater than the leaf's own, the subtraction below clamps to zero, and the line
	// collapses to color = medium: the leaf is painted over with fog and simply vanishes.
	// Thick fog over a module with its own effect is where it shows, and it took a day to
	// find because every part of it is correct on its own.
	//
	// Capping the share at the pixel makes the failure harmless instead: where the depth
	// does not belong here the share becomes the pixel, the surface part becomes zero, and
	// the occlusion is simply not applied. Doing nothing is the right answer when the only
	// thing that could say what to do is known to be wrong.
	medium = min(medium, color.rgb);

	color.rgb = medium + (color.rgb - medium) * occlusion;

	return color;
}

technique postFX_ssao		{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_ssao(8); } }
technique postFX_ssao_high	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_ssao(12); } }
technique postFX_ssao_blurX	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_ssao_blur(float2(1.0f, 0.0f)); } }
technique postFX_ssao_blurY	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_ssao_blur(float2(0.0f, 1.0f)); } }
// The occlusion on its own, for setting the radius and the strength by eye. It still goes
// through whatever the final pass does with a scene, so the grey is not literal, but where
// it darkens is exactly where occlusion was found.
float4 ps_main_postFX_ssao_show(float2 texCoord: TEXCOORD0) : COLOR
{
	return tex2D(postFX_sampler1, texCoord).r;
}

technique postFX_ssao_apply	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_ssao_apply(); } }
technique postFX_ssao_show	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_ssao_show(); } }

// ---------------------------------------------------------------------------------------
// The depth texture itself, put on the screen.
//
// Everything else here reads that texture and shows a CONSEQUENCE of what is in it, and a
// consequence can be explained four different ways - which is how four rounds went past on
// a ghost crown that moved at its own speed. This shows the thing rather than its effect:
// whatever stands in the depth is drawn, and whether it sways with the plant or stands
// still is then a matter of looking rather than of inference.
//
// LOGARITHMIC in distance, and that is not a refinement. The first version scaled depth by
// twenty, which puts everything past a fiftieth of the far clip at black - fifty metres on a
// kilometre - so the whole horizon came out indistinguishable from the sky, and a question
// about whether the distant trees are in the depth could not be asked of it at all. A view
// that cannot see past a courtyard is not a view of the depth.
//
// A decade of distance is now a fixed step of brightness: a metre is dark, ten metres a
// quarter, a hundred two thirds, the far clip white. Near is DARK and the sky is white, which
// is the other way round from before and is the way round that lets a crown be read against
// the sky it stands in front of.
float4 ps_main_postFX_depth_show(float2 texCoord: TEXCOORD0) : COLOR
{
	// Stage zero, because the stage IS the sampler: renderPostFxNode sets the texture of
	// pass i into postFX_texture[i], so a shader reading one number and a node binding
	// another does not fail - it silently reads whatever the stage was left holding. Here
	// that was the bloom blur of the frame before, which looks enough like a scene to be
	// mistaken for one.
	float depth = tex2D(postFX_sampler0, texCoord).r;

	// The stored quantity is the fraction of the way to the far clip, so this is metres over
	// a far clip the shader does not know; a thousand is the right order for every scene and
	// the only thing it changes is where the curve sits.
	float metres = depth * 1000.0f;

	return float4(saturate(log2(1.0f + metres) / log2(1.0f + 1000.0f)).xxx, 1.0f);
}

technique postFX_depth_show	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_depth_show(); } }

// ---------------------------------------------------------------------------------------
// Crepuscular rays. Light does not actually scatter anywhere here: what is drawn is the sky
// smeared outward from the sun along the direction it would have come from, so wherever
// something stands between the camera and the sky near the sun, the smear stops and a shaft
// appears beside it. Depth only, like the occlusion above - a pixel the scene drew blocks
// the sky, and a pixel it did not is sky.
//
// Three nodes again: a mask at a quarter of the width, two radial blurs over it, and an
// apply pass that writes a full size copy of the scene with the rays added, which the final
// pass reads instead of the scene itself. A module needs no edit for the same reason.

// xy: the sun in texture coordinates. z: how much of it counts - zero behind the camera,
// at night, or indoors, which is how the whole thing switches off without a branch.
// w: one over how far from the sun, across the screen, a shaft is still drawn.
float4 g_GodRays_Sun;
// x: how far along the line to the sun one blur reaches, as a fraction of it. y: the weight
// left at the far end of that reach, so how fast a shaft fades out. z: how much is added.
// w: how bright the sky has to be before it is a source at all.
float4 g_GodRays_Settings;

#define GODRAYS_SAMPLES 8

// The most of the smear any surface may take, however far away it is. The air in front of
// a hill a kilometre off really does carry a lot of light, but the distance fog is already
// drawing that, and laying the sun smear over it a second time is what turned a midday
// horizon into a blue wash. The sky itself is exempt - it IS the light.
static const float GODRAYS_AIRLIGHT_MAX = 0.25f;

// What the sun would light if nothing were in the way. Everything the scene drew is a zero
// here, and that hole is what becomes the shadow of a shaft after the blur.
float4 ps_main_postFX_godrays_mask(float2 texCoord: TEXCOORD0) : COLOR
{
	// The sky is whatever the depth pass left behind, and that pass clears its target to
	// white before drawing anything into it (rglRenderer.cpp, D3DCLEAR_TARGET 0xFFFFFFFF).
	// So the sky reads one here, not zero - the comment on the occlusion above says zero
	// and is simply wrong, which costs it nothing because its test is dead either way.
	//
	// Testing against one also means that a sampler which is not bound at all reads black
	// and the mask comes out empty, which is a visible nothing rather than a smear of the
	// whole scene pretending to be shafts.
	float sky = step(0.999f, tex2D(postFX_sampler1, texCoord).r);

	// Only what is brighter than the threshold. Two reasons, and the second is the one that
	// matters: it keeps the shafts to the part of the sky that could cast them rather than
	// smearing the whole horizon, and it drops everything the depth pass never drew.
	// That pass skips water, anything that does not write z, and the sun flare billboard
	// (rglRenderer.cpp, renderMeshEarlyZ), so each of those is left reading as sky and would
	// otherwise stand in the mask as a source of its own - a bright patch trailing a shaft
	// toward the sun from wherever it happens to be.
	// And the floor rises with the air. A threshold that is a fixed fraction of white asks
	// "is this pixel bright", when the question a shaft needs answered is "is this pixel
	// brighter than the sky around it" - and those are the same question only while the sky
	// is dark enough to leave room between them.
	//
	// Measured in Napoleonic Wars, in fog: at the shipped 0.5 the whole sky passed, the mask
	// came out even, a radial blur of an even mask is even, and the sky took a flat +10 that
	// clipped it - 68% of the sky pure white against 26% with the shafts off. The clouds went
	// with it. Raised by hand to 0.9 the same scene came back to 32%, which is the shafts
	// doing what they are for.
	//
	// The fog colour is what a distant surface fades to, so it IS the floor of the sky's
	// brightness, in fog and in clear air alike - and it is already in the same space as the
	// scene colour sampled here, which the occlusion proves by subtracting one from the other
	// a hundred lines up. Whichever of the two is higher wins: a clear day keeps the setting
	// the player chose, a white-out raises it to the only number that means anything there.
	float floor = max(g_GodRays_Settings.w, max(g_SSAO_FogColor.r, max(g_SSAO_FogColor.g, g_SSAO_FogColor.b)));
	float3 color = max(0.0f, tex2D(postFX_sampler0, texCoord).rgb - floor);

	return float4(color * sky, 1.0f);
}

// A march toward the sun, run twice. The second pass strides by what the first one covered,
// so eight taps each give the reach of sixty four - the trick is old and it is the only way
// a shaft gets long enough without the cost going with it.
//
// stepScale is uniform const, so each technique compiles its own copy and the weights fold
// into constants.
float4 ps_main_postFX_godrays_blur(uniform const float stepScale, float2 texCoord: TEXCOORD0) : COLOR
{
	float2 delta = (g_GodRays_Sun.xy - texCoord) * (g_GodRays_Settings.x * stepScale / GODRAYS_SAMPLES);

	// Between them the two passes tap a uniform grid of GODRAYS_SAMPLES squared points over
	// the reach, so the factor per tap is the end to end one spread over that grid. The far
	// pass strides GODRAYS_SAMPLES times as far and fades that much faster per tap, which is
	// what makes the two describe one curve rather than two.
	float decay = pow(g_GodRays_Settings.y, stepScale / GODRAYS_SAMPLES);

	float3 sum = 0.0f;
	float weight = 1.0f;
	float weightSum = 0.0f;
	float2 tex = texCoord;

	[unroll] for (int i = 0; i < GODRAYS_SAMPLES; ++i)
	{
		sum += tex2D(postFX_sampler0, tex).rgb * weight;
		weightSum += weight;
		weight *= decay;
		tex += delta;
	}

	// By the weights used, so the mask keeps its brightness and only its shape changes.
	return float4(sum / weightSum, 1.0f);
}

// How much air stands between the camera and this pixel, which is how much of the smear it
// is entitled to. The depth target is distance over the far clip, so it is already that
// fraction; zero means nothing was drawn, which is the sky, and the sky has all of it.
//
// Without this the shafts are added to everything alike and the sun shines through a hill
// as brightly as through the sky beside it.
float godrays_airlight(float2 texCoord)
{
	// One is the sky, and the sky is all of it; anything else is a fraction of the way to
	// the far clip and gets that fraction, up to the ceiling above.
	float depth = tex2D(postFX_sampler2, texCoord).r;

	return (depth >= 0.999f) ? 1.0f : min(depth, GODRAYS_AIRLIGHT_MAX);
}

// Added, not blended: this is light arriving on top of what is already there. It goes in
// before the tonemap, so on a bright day the curve pulls the shafts back with everything
// else instead of letting them clip.
float4 ps_main_postFX_godrays_apply(float2 texCoord: TEXCOORD0) : COLOR
{
	float4 color = tex2D(postFX_sampler0, texCoord);

	color.rgb += tex2D(postFX_sampler1, texCoord).rgb
		* (g_GodRays_Settings.z * g_GodRays_Sun.z * godrays_airlight(texCoord));

	return color;
}

// The rays on their own, for setting strength and reach by eye.
float4 ps_main_postFX_godrays_show(float2 texCoord: TEXCOORD0) : COLOR
{
	return float4(tex2D(postFX_sampler1, texCoord).rgb
		* (g_GodRays_Settings.z * g_GodRays_Sun.z * godrays_airlight(texCoord)), 1.0f);
}

technique postFX_godrays_mask	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_godrays_mask(); } }
technique postFX_godrays_blur1	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_godrays_blur(1.0f / GODRAYS_SAMPLES); } }
technique postFX_godrays_blur2	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_godrays_blur(1.0f); } }
technique postFX_godrays_apply	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_godrays_apply(); } }
technique postFX_godrays_show	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_godrays_show(); } }


#endif
#endif

////////////////////////////////////////////////////////////////////////////////////
// SMAA 1x, beside FXAA rather than in place of it.
//
// What it buys. FXAA decides what an edge is from one pixel's neighbourhood and then
// blurs across it, so whatever it mistook for an edge is softened too - lettering on a
// banner, the weave of cloth, the grain of a wall. SMAA finds an edge, walks along it
// to learn how long it is and where it ends, and reads the coverage of the line that
// edge belongs to out of a precomputed table. What it then blends is the area that line
// actually covers, so a straight edge comes out close to what multisampling would give
// while everything that is not an edge is left where it was.
//
// Three passes against FXAA's one: edges, blending weights, and the blend. That is the
// whole of the price, and it is why this is a third entry in the same list rather than a
// replacement - the player chooses between quick and soft, and dearer and sharp.
//
// The two tables are not generated here. They are the reference implementation's own
// AreaTex and SearchTex, which the engine carries as byte arrays and uploads at device
// restore: the area table is an integral an offline tool computes, and recomputing it
// would be a source of silent error for no gain. Nothing ships as a file.
//
// Self contained and looked up by name, like the occlusion above, so a module's own
// postFX.fx gets this from the include alone and none of its own techniques change.
#if PS_3 && SMAA

// Everything SMAA wants to know about the target, taken from the vector the engine
// already sends per node. Written as an expression rather than as a new uniform on
// purpose: all four components depend on uniforms alone, so the effect works them out
// once on the processor and the shader sees four constants. Per node is what is wanted -
// the edge pass and the weight pass run at full resolution here, but the expression
// follows whatever viewport the node was given rather than assuming.
#define SMAA_RT_METRICS float4(g_HalfPixel_ViewportSizeInv.z, g_HalfPixel_ViewportSizeInv.w, 1.0f / g_HalfPixel_ViewportSizeInv.z, 1.0f / g_HalfPixel_ViewportSizeInv.w)
#define SMAA_HLSL_3 1

// Three steps to sit beside FXAA's three. Low is left out: it is sixty per cent of the
// quality, and a player who wants cheap already has FXAA, which is cheaper than any
// SMAA.
#if SMAA == 1
#define SMAA_PRESET_MEDIUM 1
#elif SMAA == 2
#define SMAA_PRESET_HIGH 1
#else
#define SMAA_PRESET_ULTRA 1
#endif

#include "SMAA.hlsl"

// The half texel the engine's own post effect vertex shader adds is not cosmetic here
// and must survive. On this interface a screen quad maps pixel centres to texel corners,
// so the offset is what puts a fetch on a texel centre - and SMAA then works out pixcoord
// as texcoord times the viewport, which has to come out as a pixel centre or the table
// lookups are half a pixel out along both axes.

struct VS_OUT_SMAA_EDGES
{
	float4 Pos		: POSITION;
	float2 Tex		: TEXCOORD0;
	float4 Offset[3]: TEXCOORD1;
};

VS_OUT_SMAA_EDGES vs_main_postFX_smaa_edges(float4 pos: POSITION)
{
	VS_OUT_SMAA_EDGES Out;

	Out.Pos = pos;
	Out.Tex = (float2(pos.x, -pos.y) * 0.5f + 0.5f) + g_HalfPixel_ViewportSizeInv.xy;
	SMAAEdgeDetectionVS(Out.Tex, Out.Offset);

	return Out;
}

// Luma rather than colour. The reference recommends it, it is the cheaper of the two,
// and the input here is the final low dynamic range image in gamma space - which is what
// SMAA was written to read. A colour detector would catch edges between two patches of
// equal brightness; there are few of those in this game and they are not what the eye
// catches on.
//
// This one discards where there is no edge, which is the reference's own behaviour, and
// it is why the target it writes has to be cleared each frame: a discarded pixel keeps
// what was there before. The engine clears it.
float4 ps_main_postFX_smaa_edges(VS_OUT_SMAA_EDGES In) : COLOR
{
	return float4(SMAALumaEdgeDetectionPS(In.Tex, In.Offset, postFX_sampler0), 0.0f, 0.0f);
}

struct VS_OUT_SMAA_WEIGHTS
{
	float4 Pos		: POSITION;
	float2 Tex		: TEXCOORD0;
	float2 PixCoord	: TEXCOORD1;
	float4 Offset[3]: TEXCOORD2;
};

VS_OUT_SMAA_WEIGHTS vs_main_postFX_smaa_weights(float4 pos: POSITION)
{
	VS_OUT_SMAA_WEIGHTS Out;

	Out.Pos = pos;
	Out.Tex = (float2(pos.x, -pos.y) * 0.5f + 0.5f) + g_HalfPixel_ViewportSizeInv.xy;
	SMAABlendingWeightCalculationVS(Out.Tex, Out.PixCoord, Out.Offset);

	return Out;
}

// The search table goes on sampler 4 because that is the one stage of the five the
// engine filters by point rather than linearly. It matters: the pass reads a search
// length out of that table by what amounts to an index, and a filtered read between two
// entries is a length that belongs to neither. The area table, on the other hand, HAS to
// be linear - the coverage it holds is a continuous function and the lookup is meant to
// interpolate.
//
// The last argument is the subsample index, which is zero for SMAA 1x: it exists for the
// temporal and multisampled variants, neither of which is in play.
float4 ps_main_postFX_smaa_weights(VS_OUT_SMAA_WEIGHTS In) : COLOR
{
	return SMAABlendingWeightCalculationPS(In.Tex, In.PixCoord, In.Offset,
		postFX_sampler0, postFX_sampler1, postFX_sampler4, float4(0.0f, 0.0f, 0.0f, 0.0f));
}

struct VS_OUT_SMAA_BLEND
{
	float4 Pos		: POSITION;
	float2 Tex		: TEXCOORD0;
	float4 Offset	: TEXCOORD1;
};

VS_OUT_SMAA_BLEND vs_main_postFX_smaa_blend(float4 pos: POSITION)
{
	VS_OUT_SMAA_BLEND Out;

	Out.Pos = pos;
	Out.Tex = (float2(pos.x, -pos.y) * 0.5f + 0.5f) + g_HalfPixel_ViewportSizeInv.xy;
	SMAANeighborhoodBlendingVS(Out.Tex, Out.Offset);

	return Out;
}

float4 ps_main_postFX_smaa_blend(VS_OUT_SMAA_BLEND In) : COLOR
{
	return SMAANeighborhoodBlendingPS(In.Tex, In.Offset, postFX_sampler0, postFX_sampler1);
}

// And the edges on their own, for looking at. Red and green are the two axes of the edge
// mask, so a vertical silhouette lights one channel and a horizontal one the other; what
// has to be judged here is that the mask follows silhouettes and NOT the inside of a
// texture, because everything the mask covers is what the blend is allowed to touch.
float4 ps_main_postFX_smaa_show(float2 texCoord: TEXCOORD0) : COLOR
{
	return float4(tex2D(postFX_sampler1, texCoord).rg, 0.0f, 1.0f);
}

technique postFX_smaa_edges	{ pass P0 { VertexShader = compile vs_3_0 vs_main_postFX_smaa_edges(); PixelShader = compile ps_3_0 ps_main_postFX_smaa_edges(); } }
technique postFX_smaa_weights	{ pass P0 { VertexShader = compile vs_3_0 vs_main_postFX_smaa_weights(); PixelShader = compile ps_3_0 ps_main_postFX_smaa_weights(); } }
technique postFX_smaa_blend	{ pass P0 { VertexShader = compile vs_3_0 vs_main_postFX_smaa_blend(); PixelShader = compile ps_3_0 ps_main_postFX_smaa_blend(); } }
technique postFX_smaa_show	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_3_0 ps_main_postFX_smaa_show(); } }

#endif

/////////////////////////////////////////////////////////////////////////////////////
// The frame's own depth, turned into the one every reader of the depth target expects.
//
// The depth pre-pass draws the whole scene a second time with shaders of its own, which is
// why a surface the frame animates ends up in the depth where it is not. A depth buffer the
// driver lets us read back needs no second pass at all: it was written by the very shaders
// that drew the frame, so there is nothing left for the two to disagree about.
//
// What it holds is not what the readers want, though. A depth buffer stores the WINDOW depth,
// which is hyperbolic - most of its range spent on the nearest few metres - while the target
// filled by the pre-pass holds Out.Pos.z / far_clip, which for a standard projection is
// (viewZ - near) / (far - near): linear in view space, which is what SSAO turns back into a
// distance with one multiply and an add.
//
// The conversion between them is exact. With zw the window depth, n the near plane and f the
// far one:
//
//     viewZ  = n*f / (f - zw*(f - n))
//     stored = (viewZ - n) / (f - n) = n*zw / (f - zw*(f - n))
//
// g_FrameDepth_Projection carries (n, f, f - n). Nothing else about the camera is needed.
//
// Point sampling is not asked for and is not needed: this pass covers the target one texel
// for one texel, so every fetch lands on a texel centre and linear filtering returns exactly
// the same value it would.
float4 g_FrameDepth_Projection;

float4 ps_main_postFX_frame_depth(float2 texCoord: TEXCOORD0) : COLOR
{
	float zw = tex2D(postFX_sampler0, texCoord).r;

	// The far plane writes zw = 1, where the expression below returns exactly 1 as well -
	// the sky comes out at the far distance rather than at a division by nothing.
	// Written as n + (f - n)*(1 - zw) rather than the f - zw*(f - n) it is equal to, because
	// the two are equal in algebra and not in arithmetic. At the far plane zw is one, and the
	// second form subtracts two nearly equal large numbers: 1000 - 999.9 comes out as
	// 0.10003662 in single precision instead of 0.1, and the result lands three ten
	// thousandths below one across the whole sky. This form computes 1 - zw exactly there -
	// it is zero - and returns n/n, which is exactly one.
	//
	// It would never have been noticed without the comparison view amplifying it a
	// hundredfold, and it would never have mattered: nothing reads the depth at the far
	// plane. It is fixed because a comparison with a known error in it cannot be used to
	// judge anything else.
	float stored = (g_FrameDepth_Projection.x * zw)
		/ (g_FrameDepth_Projection.x + g_FrameDepth_Projection.z * (1.0f - zw));

	return stored;
}

technique postFX_frame_depth	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_2_0 ps_main_postFX_frame_depth(); } }

// The two depths side by side, which is the only question worth asking while both exist.
// Stage zero is the depth pre-pass target, stage one the same quantity taken from the frame's
// own depth buffer. They must agree everywhere except where they are MEANT to differ: the
// water surface and the soft particles are in neither, and whatever the pre-pass leaves out
// of its own accord is in the second only.
//
// The difference is shown signed and amplified, because what matters is not how large it is
// but whether it is anywhere at all:
//
//   green   the frame's depth is NEARER - something the pre-pass did not write, or wrote further
//   red     the pre-pass is nearer - something it wrote that the frame does not have there,
//           which is exactly the shape a ghost takes
//   grey    agreement, shaded by the depth itself so the scene stays readable underneath
//
// The magnitude is banded by decade rather than scaled, because a single gain cannot answer the
// question this view is for. Everything from a millimetre to a hundred metres saturates one
// channel at a hundredfold, and the hypotheses worth telling apart are separated by exactly
// that span: a fragment that lost the pre-pass's own biased z-test to its neighbour is a
// centimetre or two out, a record missing from the pre-pass altogether is tens of metres out.
//
// Three bands, and the channel value is the reading:
//
//     a third  - a centimetre to a decimetre
//     two thirds - a decimetre to a metre
//     full     - a metre and beyond
//
// Below a centimetre nothing is drawn: that is the depth target's own quantisation and the
// slope-scaled bias, neither of which is a disagreement about where a surface is.
//
// Green still means the pre-pass is the farther of the two, red that it is the nearer, so what
// the view meant before it still means. The scene underneath is dimmer than the lowest band so
// that the bands stay separable from it by value alone.
float4 ps_main_postFX_depth_diff(float2 texCoord: TEXCOORD0) : COLOR
{
	float prePass = tex2D(postFX_sampler0, texCoord).r;
	float frame = tex2D(postFX_sampler1, texCoord).r;

	// Far minus near: the stored fraction times this is the distance, by the construction of the
	// resolve pass above. A kilometre is the stand-in for a view that has not resolved yet.
	float range = max(g_FrameDepth_Projection.z, 1.0f);
	float size = abs(prePass - frame) * range;

	// Both distances, each over 32 metres, which is 12 cm a level: red is what the frame holds,
	// blue what the pre-pass holds. Where they agree the two channels are equal and the pixel is
	// an even purple, so the view checks itself - the scene has to come out neutral everywhere
	// except where something is genuinely wrong.
	//
	// Green keeps the band, and only above a decimetre, so that a disagreement worth reading is
	// still findable at a glance without colouring the quantisation noise of the far field.
	float3 colour = float3(saturate(frame * range / 32.0f), 0.0f, saturate(prePass * range / 32.0f));

	colour.g = size >= 0.10f ? (size >= 1.00f ? 1.0f : 0.5f) : 0.0f;

	return float4(colour, 1.0f);
}

technique postFX_depth_diff	{ pass P0 { VertexShader = vs_main_postFX_compiled; PixelShader = compile ps_2_0 ps_main_postFX_depth_diff(); } }
