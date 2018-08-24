## from combinatorics.jl. Allows for negative values
function _factorial(n::T, k::T) where {T <: Integer}
    k > n && throw(DomainError())
    k == n && return one(T)
    f = one(T)
    for i in (k+1):n
        f = Base.checked_mul(f,i)
    end
    return f
end

function diff(p::MPoly{T}, symbol::Symbol, n::Int=1) where {T}
    idx = 0
    for (i, var) in enumerate(vars(p))
        if var == symbol
            idx = i
            break
        end
    end
    if idx == 0 # symbol was not found
        return zero(p)
    end

    dp = zero(p)

    for (m, c) in p
        m2 = copy(m)
        m2[idx] = m[idx] - n
        dp[m2] = p[m] * _factorial(m[idx], m2[idx])
    end
    return dp
end

function integrate(p::MPoly{T}, symbol::Symbol, n::Int=1) where {T}
    if !(symbol in vars(p))
        return (MPoly{T}(symbol)^n * p) / factorial(n)
    end
    dp = zero(p)
    idx = findfirst(isequal(symbol), vars(p))

    for (m, c) in p
        m2 = copy(m)
        m2[idx] = m[idx] + n
        if m[idx] + 1 <= 0 <= m2[idx]
            throw(ArgumentError("can't integrate $n times in $(symbol) as it would involve a -1 power requiring a log term"))
        end
        c =  _factorial(m2[idx], m[idx])
        dp[m2] = p[m] * 1 / c
    end
    return dp
end

