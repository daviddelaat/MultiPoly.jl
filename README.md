# Sparse multivariate polynomials

This package provides support for working with sparse multivariate polynomials in Julia. 

## Installation

In the Julia REPL run
```julia
Pkg.clone("git://github.com/daviddelaat/MultiPoly.jl.git")
```

## The MPoly type

Multivariate polynomials are stored in the type
```julia
immutable MPoly{T}
    terms::Dict{Vector{Int},T}
    vars::Vector{Symbol}
end
```
Here each item in the dictionary `terms` corresponds to a term in the polynomial, where the key represents the monomial powers and the value the coefficient of the monomial. Each of the keys in `terms` should be a vector of integers whose length equals `length(vars)`.

## Constructing polynomials

For constructing polynomials you can use the generators of the polynomial ring:
```julia
julia> using MultiPoly

julia> x, y = generators(MPoly{Float64}, :x, :y)
2-element Array{MPoly{Float64},1}:
 MPoly{Float64}(x)
 MPoly{Float64}(y)

julia> p = (x+y)^3
MPoly{Float64}(3.0x^2*y + x^3 + 3.0x*y^2 + y^3)
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
MPoly{Float64}([[0,0] => 1.0, [2,0] => 1.0, [1,3] => 2.0], [:x, :y])
```

## Polynomial arithmetic

The usual ring arithmetic is supported and MutliPoly will automatically deal with polynomials in different variables or having a different coefficient type. Examples:
```julia
julia> using MultiPoly

julia> x, y = generators(MPoly{Float64}, :x, :y)
2-element Array{MPoly{Float64},1}:
 MPoly{Float64}(x)
 MPoly{Float64}(y)

julia> z = generator(MPoly{Int}, :z)
MPoly{Int64}(z)

julia> x+z
MPoly{Float64}(z + x)

julia> vars(x+z)
3-element Array{Symbol,1}:
 :x
 :y
 :z
```
