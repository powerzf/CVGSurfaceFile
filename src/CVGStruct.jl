abstract type CVGSurface end

struct Triangle <: CVGSurface
    triangleID :: Int64
    x :: Float64
    y :: Float64
    z :: Float64
end
Triangle() = Triangle(1,1.0,1.0,1.0)
    


struct TrBoundry <:CVGSurface
    triangleID1 :: Int64
    triangleID2 :: Int64
    triangleID3 :: Int64
    boundryID ::Int64
end
TrBoundry() = TrBoundry(1,1,1,1)
    

struct Surface <: CVGSurface
    n_max_vertex :: Int64
    n_vertices :: Int64
    n_triangles :: Int64
    triangles :: Array{Triangle,1}
    surfaces :: Array{TrBoundry,1}
end

