x, y = generators(MPoly{Float64}, :x, :y)

@test vars(x) == [:x, :y]
@test nvars(x) == 2
@test eltype(x) == Float64
