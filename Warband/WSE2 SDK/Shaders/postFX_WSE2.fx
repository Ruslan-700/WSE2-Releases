
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
#endif
