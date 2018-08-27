struct MPoly{T}
    terms::OrderedDict{Vector{Int},T}
    vars::Vector{Symbol}
end

terms(p::MPoly) = p.terms

eltype(::MPoly{T}) where {T}= T

vars(p::MPoly) = p.vars

nvars(p::MPoly) = length(vars(p))

zero(::Type{MPoly{T}}; vars::Vector{Symbol}=Symbol[]) where {T} = MPoly{T}(OrderedDict{Vector{Int},T}(), vars)
zero(p::MPoly{T}) where {T} = zero(MPoly{T}, vars=vars(p))

one(::Type{MPoly{T}}; vars::Vector{Symbol}=Symbol[]) where {T} = MPoly{T}(OrderedDict(zeros(Int, length(vars)) => one(T)), vars)
one(p::MPoly{T}) where {T} = one(MPoly{T}, vars=vars(p))

function generators(::Type{MPoly{T}}, vars::Symbol...) where {T}
    m = Matrix(I, length(vars), length(vars))
     [MPoly{T}(OrderedDict(m[:,i] => one(T)), [vars...]) for i = 1:length(vars)]
end

generator(::Type{MPoly{T}}, var::Symbol) where {T} =
     MPoly{T}(OrderedDict([1] => one(T)), [var])

MPoly{T}(var::Symbol) where {T} =
     MPoly{T}(OrderedDict([1] => one(T)), [var])

MPoly(var::Symbol) =
     MPoly{Float64}(var)

promote_rule(::Type{MPoly{T}}, ::Type{MPoly{U}}) where {T,U} = MPoly{promote_type(T, U)}
promote_rule(::Type{MPoly{T}}, ::Type{U}) where {T,U} = MPoly{promote_type(T, U)}

function convert(P::Type{MPoly{T}}, p::MPoly{T}) where {T}
    p
end

function convert(P::Type{MPoly{T}}, p::MPoly) where {T}
    r = zero(P, vars=vars(p))
    for (m, c) in p
        r[m] = convert(T, c)
    end
    r
end

convert(::Type{MPoly{T}}, c::T) where {T} =
    MPoly{T}(OrderedDict(Int[] => c))

monomials(p::MPoly) = keys(terms(p))

getindex(p::MPoly{T}, m::Vector{Int}) where {T} =
    get(terms(p), m, zero(T))

getindex(p::MPoly, m::Int...) = p[[m...]]

function setindex!(p::MPoly{T}, v, m::Int...) where {T}
    v = convert(T, v)
    if hasmethod(isapprox, (T,T)) && isapprox(v, zero(T))
        delete!(terms(p), [m...])
    else
        terms(p)[[m...]] = v
    end
end

setindex!(p::MPoly{T}, v, m::Vector{Int}) where {T} = p[m...] = v

Base.iterate(p::MPoly) = iterate(terms(p))
Base.iterate(p::MPoly, state) = iterate(terms(p), state)

copy(p::MPoly{T}) where {T} = MPoly{T}(copy(terms(p)), copy(vars(p)))

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
        if !isapprox(q[m], c)
            return false
        end
    end
    for (m, c) in q
        if !isapprox(p[m], c)
            return false
        end
    end
    true
end
