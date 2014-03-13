module MultiPoly 

export 
    MPoly, terms, vars, nvars, generators, generator, monomials, deg,
    PolyUnion, newexps, oldexps,
    harmonicpolynomialdim, laplaceharmonicpol,
    evaluate

import Base: zero, one,
    show, print, length, endof, getindex, setindex!, copy, promote_rule, convert, start, next, done, eltype,
    *, /, //, -, +, ==, divrem, conj, rem, real, imag

include("mpoly.jl")
include("mpolyarithmetic.jl")
include("mpolyprinting.jl")
include("polyunion.jl")
include("mpolyevaluation.jl")

end # module
