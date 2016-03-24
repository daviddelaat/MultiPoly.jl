x, y = generators(MPoly{Float64}, :x, :y)

p = 4.0 + x^3 + 3.0*x*y^2 + y^3
q =  x^(-2)*y^2
r = x^(-1) * y

@test diff(p, :x, 1) == 3.0x^2 + 3.0y^2
@test diff(p, :x, 2) == 6.0x
@test diff(p, :x, 3) == 6.0 * one(p)
@test diff(p, :y, 1) == 6x*y + 3y^2
@test diff(p, :z) == zero(p)
@test p == 4.0 + x^3 + 3*x*y^2 + y^3 # Check p is left alone

@test diff(q, :x) == -2*x^(-3)*y^2
@test diff(q, :y) == 2*x^(-2)*y

p2 = x
@test diff(p2, :x, 1) == 1.0 * one(p)
@test diff(p2, :y, 1) == zero(p)


p1 = 3.0 + 3x + y^2
@test integrate(p1, :x, 1) == 3.0x + 3*x^2 * 0.5 + x*y^2
@test integrate(p1, :y, 2) == 1.5*y^2 + 1.5x*y^2 + (1/3 * 1/4) * y^4
pz = MPoly{Float64}(:z)
@test integrate(p1, :z) == pz * p1
@test integrate(p1, :z, 2) == pz^2 * p1 / 2.0
@test p1 == 3.0 + 3x + y^2 # Check p is left alone


@test integrate(q, :x) == -x^(-1)*y^2
@test integrate(r, :y) == x^(-1)*y^2/2
@test_throws ArgumentError integrate(q, :x, 2) 
@test_throws ArgumentError integrate(r, :x) 
