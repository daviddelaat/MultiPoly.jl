immutable MPoly{T}
    terms::Dict{Vector{Int},T}
    vars::Vector{Symbol}
end

terms(p::MPoly) = p.terms

eltype{T}(::MPoly{T}) = T

vars(p::MPoly) = p.vars

nvars(p::MPoly) = length(vars(p))

zero{T}(::Type{MPoly{T}}; vars::Vector{Symbol}=Symbol[]) = MPoly{T}(Dict{Vector{Int},T}(), vars)
zero{T}(p::MPoly{T}) = zero(MPoly{T}, vars=vars(p))

one{T}(::Type{MPoly{T}}; vars::Vector{Symbol}=Symbol[]) = MPoly{T}([zeros(Int, length(vars)) => one(T)], vars)
one{T}(p::MPoly{T}) = one(MPoly{T}, vars=vars(p))

function generators{T}(::Type{MPoly{T}}, vars::Symbol...)
     m = eye(Int, length(vars))
     [MPoly{T}([m[:,i] => one(T)], [vars...]) for i = 1:length(vars)]
end

generator{T}(::Type{MPoly{T}}, var::Symbol) =
     MPoly{T}([[1] => one(T)], [var])

promote_rule{T,U}(::Type{MPoly{T}}, ::Type{MPoly{U}}) = MPoly{promote_type(T, U)}
promote_rule{T,U}(::Type{MPoly{T}}, ::Type{U}) = MPoly{promote_type(T, U)}

function convert{T}(P::Type{MPoly{T}}, p::MPoly)
    r = zero(P, vars=vars(p))
    for (m, c) in p
        r[m] = convert(T, c)
    end
    r
end

convert{T}(::Type{MPoly{T}}, c::T) = 
    MPoly{T}([Int[] => c]) 

monomials(p::MPoly) = keys(terms(p))

getindex{T}(p::MPoly{T}, m::Vector{Int}) = 
    get(terms(p), m, zero(T))

getindex(p::MPoly, m::Int...) = p[[m...]]

function setindex!{T}(p::MPoly{T}, v, m::Int...)
    v = convert(T, v)
    if isapprox(v, zero(T), atol=0.000001)
        delete!(terms(p), [m...])
    else
        terms(p)[[m...]] = v
    end
end

setindex!{T}(p::MPoly{T}, v, m::Vector{Int}) = p[m...] = v
    
start(p::MPoly) = start(terms(p))
next(p::MPoly, state) = next(terms(p), state)
done(p::MPoly, state) = done(terms(p), state)

copy{T}(p::MPoly{T}) = MPoly{T}(copy(terms(p)), copy(vars(p)))

function deg(p::MPoly)
    d = 0
    for m in monomials(p)
        s = sum(m)
        if s > d
            d = s
        end
    end
    d
end

function ==(p::MPoly, q::MPoly)
    for (m, c) in p
        if !isapprox(q[m], c, atol=0.000001)
            return false
        end
    end
    for (m, c) in q
        if !isapprox(p[m], c, atol=0.000001)
            return false
        end
    end
    true
end
