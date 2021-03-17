using CVGSurfaceFile

files = "file\\surface.dat"
surface_struct = cvgseek(files)
save_cvgfile("file\\out.dat", surface_struct)

cvgseek2(files)
open(files)