# Sparse multivariate polynomials

This package provides support for working with sparse multivariate polynomials in Julia. 

Currently this package is not maintained. See [MultivariatePolynomials.jl](https://github.com/blegat/MultivariatePolynomials.jl) for another Julia package for multivariate polynomials or in the future [Nemo.jl](https://github.com/wbhart/Nemo.jl).

## Installation

In the Julia REPL run
```julia
Pkg.add("MultiPoly")
```

## The MPoly type

Multivariate polynomials are stored in the type
```julia
immutable MPoly{T}
    terms::OrderedDict{Vector{Int},T}
    vars::Vector{Symbol}
end
```
Here each item in the dictionary `terms` corresponds to a term in the polynomial, where the key represents the monomial powers and the value the coefficient of the monomial. Each of the keys in `terms` should be a vector of integers whose length equals `length(vars)`.

## Constructing polynomials

For constructing polynomials you can use the generators of the polynomial ring:
```julia
julia> using MultiPoly

julia> x, y = generators(MPoly{Float64}, :x, :y);

julia> p = (x+y)^3
MultiPoly.MPoly{Float64}(x^3 + 3.0x^2*y + 3.0x*y^2 + y^3)
```
For the zero and constant one polynomials use
```julia
zero(MPoly{Float64})
one(MPoly{Float64})
```
where you can optionally supply the variables of the polynomials with `vars = [:x, :y]`.

Alternatively you can construct a polynomial using a dictionary for the terms:
```julia
MPoly{Float64}(terms, vars)
```
For example, to construct the polynomial `1 + x^2 + 2x*y^3` use
```julia
julia> using MultiPoly, DataStructures

julia> MPoly{Float64}(OrderedDict([0,0] => 1.0, [2,0] => 1.0, [1,3] => 2.0), [:x, :y])
MultiPoly.MPoly{Float64}(1.0 + x^2 + 2.0x*y^3)
```

Laurent polynomials may be constructed too:
```julia
x^1 * y^2 + x^1 * y^(-2) + x^(-1) * y^2 + x^(-1) * y^(-2)
```

## Polynomial arithmetic

The usual ring arithmetic is supported and MutliPoly will
automatically deal with polynomials in different variables or having a
different coefficient type. Examples:

```julia
julia> using MultiPoly

julia> x, y = generators(MPoly{Float64}, :x, :y);

julia> z = generator(MPoly{Int}, :z)
MPoly{Int64}(z)

julia> x+z
MPoly{Float64}(x + z)

julia> vars(x+z)
3-element Array{Symbol,1}:
 :x
 :y
 :z
```

## Evaluating a polynomial

To evaluate a polynomial *P(x,y, ...)* at a point *(x0, y0, ...)* the `evaluate` function is used. Example:
```julia
julia> p = (x+x*y)^2
MultiPoly.MPoly{Float64}(x^2 + 2.0x^2*y + x^2*y^2)

julia> evaluate(p, 3.0, 2.0)
81.0
```

## Calculus

MultiPoly supports integration and differentiation. Currently the integrating constant is set to 0. Examples:
```julia
julia> p = x^4 + y^4
MultiPoly.MPoly{Float64}(x^4 + y^4)

julia> diff(p, :x)
MultiPoly.MPoly{Float64}(4.0x^3)

julia> diff(p, :y, 3)
MultiPoly.MPoly{Float64}(24.0y)

julia> integrate(p, :x, 2)
MultiPoly.MPoly{Float64}(0.03333333333333333x^6 + 0.5x^2*y^4)

```

Integrations which would involve integrating a term with a -1 power
raise an error. This example can be intergrated once, but not twice, in
`:x` and can't be integrated in `:y`:

```julia
julia> q = x^(-2) * y^(-1);
julia> integrate(q, :y)  
ERROR: ArgumentError: can't integrate 1 times in y as it would involve a -1 power requiring a log term
```
