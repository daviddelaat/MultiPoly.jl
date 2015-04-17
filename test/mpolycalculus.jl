x, y = generators(MPoly{Float64}, :x, :y)

p = 4.0 + x^3 + 3.0*x*y^2 + y^3
@test diff(p, :x, 1) == 3.0x^2 + 3.0y^2
@test diff(p, :x, 2) == 6.0x
@test diff(p, :x, 3) == 6.0 * one(p)
@test diff(p, :y, 1) == 6x*y + 3y^2
@test_throws UndefVarError diff(p, :z)
@test p == 4.0 + x^3 + 3*x*y^2 + y^3 # Check p is left alone

p2 = x
@test diff(p2, :x, 1) == 1.0 * one(p)
@test diff(p2, :y, 1) == zero(p)


p1 = 3.0 + 3x + y^2
@test integrate(p1, :x, 1) == 3.0x + 3*x^2 * 0.5 + x*y^2
@test integrate(p1, :y, 2) == 1.5*y^2 + 1.5x*y^2 + (1/3 * 1/4) * y^4
@test_throws UndefVarError integrate(p, :z)
@test p1 == 3.0 + 3x + y^2 # Check p is left alone