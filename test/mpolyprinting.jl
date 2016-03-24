x, y = generators(MPoly{Float64}, :x, :y)

@test string((x+y)^3) == "x^3 + 3.0x^2*y + 3.0x*y^2 + y^3"
@test string((x*y)^(-2)) == "x^(-2)*y^(-2)"
