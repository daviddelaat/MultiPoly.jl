x, y = generators(MPoly{Float64}, :x, :y)

p = (x+y)^2
@test_approx_eq evaluate(p, 1, 2) 3^2
@test evaluate_basis(p, 1, 2) == [1.0, 4.0, 4.0]

p = (x+2y)^3
@test_approx_eq evaluate(p, 0, 2) 2^3
@test evaluate_basis(p, 0, 2) == [1.0, 4.0, 4.0]

