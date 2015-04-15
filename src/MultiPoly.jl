module MultiPoly

export
    MPoly, terms, vars, nvars, generators, generator, monomials, deg,
    PolyUnion, newexps, oldexps,
    harmonicpolynomialdim, laplaceharmonicpol,
    evaluate, diff, integrate

import Base: zero, one,
    show, print, length, endof, getindex, setindex!, copy, promote_rule, convert, start, next, done, eltype,
    *, /, //, -, +, ==, divrem, conj, rem, real, imag, diff

include("mpoly.jl")
include("mpolyarithmetic.jl")
include("mpolyprinting.jl")
include("polyunion.jl")
include("mpolyevaluation.jl")
include("mpolycalculus.jl")

end # module
