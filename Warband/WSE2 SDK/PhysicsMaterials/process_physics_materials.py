from resource_physics_materials import *
import struct

def write_int(ofile, value):
	ofile.write(struct.pack('I', value))

def write_str(ofile, value):
	write_int(ofile, len(value))
	for c in value:
		ofile.write(struct.pack('c', c))
		
def write_float(ofile, value):
	ofile.write(struct.pack('f', value))		

def write_physics_materials():
	ofile = open("core_physics_materials.brf", "wb")
	write_str(ofile, "rfver ")
	write_int(ofile, 1)
	write_str(ofile, "physics_material")
	write_int(ofile, len(physics_materials))
	for physics_material in physics_materials:
		write_str(ofile, physics_material[0])
		write_int(ofile, physics_material[1])
		write_float(ofile, physics_material[2])
	write_str(ofile, "end")
	ofile.close()

print "Exporting physics materials..."
write_physics_materials()
