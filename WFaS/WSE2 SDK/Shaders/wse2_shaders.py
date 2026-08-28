# Builds wse2_shaders.brf - the five skinning shader records that the stock
# core_shaders.brf does not carry.
#
# Vanilla ships the non-skinning half of each of these and nothing to pair it with,
# so a mesh whose bone weights disagree with its shader has nowhere to be redirected.
# The techniques these records name are not declared by the effect Warband ships
# either; the shader patch supplies a rebuilt effect that adds them, and this file
# supplies the records. The engine loads the result by itself, from the module's
# Resource folder or from CommonRes.
#
# The record layout is the vanilla one - name, flags, requirement flags, technique,
# alternatives, stage count - so the file reads on a stock engine as well, where the
# records simply go unused.
#
# Flags mirror the vanilla counterpart exactly, with shf_special cleared and
# shf_uses_skinning set. Clearing shf_special is what makes the pair work at all:
# see rglShader::getVertexDeclarationType, where shf_special wins for a shader that
# does not skin and selects a declaration carrying no blend weights. Without it
# cleared the skinned variant would land on that same declaration and starve.
#
# Run with any Python 2 or 3. Output goes next to this script.

import struct, os

shf_specular_enable = 0x20
shf_static_lighting = 0x80
shf_uses_hlsl       = 0x20000000
shf_uses_normal_map = 0x40000000
shf_uses_skinning   = 0x80000000

shrf_lo_quality  = 0x1000
shrf_mid_quality = 0x2000
shrf_hi_quality  = 0x4000

# name, technique, flags, requirement flags, alternatives
shaders = [
	("faceshader_high_skin", "face_shader_skin_high",
		shf_specular_enable|shf_uses_hlsl|shf_uses_normal_map|shf_uses_skinning,
		shrf_mid_quality, ["faceshader_simple_skin"]),
	("faceshader_high_specular_skin", "faceshader_skin_high_specular",
		shf_specular_enable|shf_uses_hlsl|shf_uses_normal_map|shf_uses_skinning,
		shrf_hi_quality, ["faceshader_high_skin"]),
	("faceshader_simple_skin", "faceshader_skin_simple",
		shf_uses_hlsl|shf_uses_skinning,
		0, ["faceshader"]),
	("simple_shader_with_skin", "simple_shading_with_skin",
		shf_static_lighting|shf_uses_hlsl|shf_uses_skinning,
		0, ["tex_mul_color_mul_factor_alpha_static_ffp"]),
	("simple_shader_no_mip_with_skin", "simple_shading_no_filter_with_skin",
		shf_static_lighting|shf_uses_hlsl|shf_uses_skinning,
		0, ["tex_mul_color_mul_factor_alpha_static_ffp"]),
]

def write_int(f, value):
	f.write(struct.pack('<i', value))

def write_uint(f, value):
	f.write(struct.pack('<I', value))

def write_str(f, value):
	data = value.encode('ascii')
	write_int(f, len(data))
	f.write(data)

def main():
	path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "wse2_shaders.brf")
	f = open(path, "wb")
	write_str(f, "rfver ")
	write_int(f, 1)
	write_str(f, "shader")
	write_int(f, len(shaders))

	for name, technique, flags, requirement, alternatives in shaders:
		write_str(f, name)
		write_uint(f, flags)
		write_uint(f, requirement)
		write_str(f, technique)
		write_int(f, len(alternatives))

		for alternative in alternatives:
			write_str(f, alternative)

		write_int(f, 0) # stage count, unused by the engine

	write_str(f, "end")
	f.close()
	print("wrote %s (%d shaders, %d bytes)" % (path, len(shaders), os.path.getsize(path)))

main()
