import Main.CVGSurfaceFile as Cvf

files = "file\\surface.dat"
surface_struct = Cvf.cvgseek(files)
Cvf.save_cvgfile("file\\out.dat", surface_struct)