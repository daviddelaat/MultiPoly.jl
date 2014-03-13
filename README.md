# Sparse multivariate polynomials

This package provides support for working with sparse multivariate polynomials in Julia. 

## Installation

In the Julia REPL run
```julia
Pkg.clone("https://github.com/daviddelaat/MultiPoly.jl.git")
```

## The Mpoly type

Multivariate polynomials are stored in the type
```julia
immutable MPoly{T}
    terms::Dict{Vector{Int},T}
    vars::Vector{Symbol}
end
```

## Constructing polynomials

For constructing polynomials you can use the generators of the polynomial ring:
```julia   
x, y = generators(MPoly{Float64}, :x, :y)
p = (x+y)^3
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

The usual ring arithmetic is supported where it is not necessary for polynomials to have the same variables or coefficient type.
