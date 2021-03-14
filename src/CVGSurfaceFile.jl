module CVGSurfaceFile

    include("CVGStruct.jl")
2+23
    export cvgseek, save_cvgfile
    export CVGSurface, Triangle, TrBoundry, Surface
    #将原始的.dat文件转化为自定义类型
    function cvgseek(file)
        filestream = open(file)
    
        fileline = readline(filestream)
        
        n_max_vertex, n_vertices, n_triangles = parse.(Int,split(fileline))
    
        triangles = Triangle[]
        trBoundry = TrBoundry[]
    
        for i in 1:n_vertices
            pos = position(filestream)
            seek(filestream, pos)
            string_triangleID, string_xyz... = split(readline(filestream),' ')
            triangleID = parse(Int,string_triangleID)
            x, y, z =  parse.(Float64,string_xyz)
            push!(triangles,Triangle(triangleID, x, y, z))    
        end
    
        for i in 1:n_triangles
            pos = position(filestream)
            seek(filestream, pos)
            triangleID1, triangleID2, triangleID3, boundryID = parse.(Int,split(readline(filestream), ' '))
            push!(trBoundry, TrBoundry(triangleID1, triangleID2, triangleID3, boundryID))
        end
    
        return Surface(n_max_vertex, n_vertices, n_triangles, triangles, trBoundry)
     
    end
    
    
    
    #给string函数添加方法
    Base.string(cvgsurface::Triangle) = string(cvgsurface.triangleID, " ", cvgsurface.x, " ", cvgsurface.y, " ", cvgsurface.z)
    Base.string(cvgTrBoundry::TrBoundry) = string(cvgTrBoundry.triangleID1, " ", cvgTrBoundry.triangleID2, " ", cvgTrBoundry.triangleID3, " ", cvgTrBoundry.boundryID)
    
    #将自定义数据转化为字符串数组数据
    function cvg_surface_string(surface::CVGSurface)
        arr_string = String[]
        push!(arr_string,string(surface.n_max_vertex, " ", surface.n_vertices, " ",surface.n_triangles))
        append!(arr_string,string.(surface.triangles))
        append!(arr_string,string.(surface.surfaces))
        return arr_string
    end
    
    #将自定义数据直接保存为.dat文件
    function save_cvgfile(file::String, surface::CVGSurface)
        open(file, "w") do io
            write(io, string(surface.n_max_vertex, " ", surface.n_vertices, " ",surface.n_triangles, '\n'))
            for i in string.(surface.triangles)
                write(io, i * '\n')
            end
    
            for i in string.(surface.surfaces)
                write(io, i * '\n')
            end
        end
    end

end
