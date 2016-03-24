x, y = generators(MPoly{Float64}, :x, :y)

@test (x+y)^2 == x^2 + 2x*y + y^2
@test x*(2x-y+1)^2 + 1 == 4x^3 - 4x^2*y + 4x^2 + y^2*x - 2x*y + x + 1
@test x + 1 == x + 1.0
@test x[1,0] == 1.0
@test x[0,1] == 0.0
@test eltype(x + im) == Complex{Float64}

@test  (x^(-1))[-1,0] == 1.0
@test_throws ArgumentError (x*y + x)^(-1) 

