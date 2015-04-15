function diff{T}(p::MPoly{T}, symbol::Symbol, n::Int=1)
    if !(symbol in vars(p))
        # Should we just return zero(p) here?
        throw(UndefVarError(:symbol))
    end

    dp = zero(p)
    idx = find(vars(p) .== symbol)[1]

    for (m, c) in p
        if m[idx] - n < 0
            continue
        end
        m2 = copy(m)
        m2[idx] = m[idx] - n
        dp[m2] = p[m] * factorial(m[idx], m[idx] - n)
    end
    return dp
end

function integrate{T}(p::MPoly{T}, symbol::Symbol, n::Int=1)
    if !(symbol in vars(p))
        # Should we just return something like p * symbol here?
        throw(UndefVarError(:symbol))
    end
    dp = zero(p)
    idx = find(vars(p) .== symbol)[1]

    for (m, c) in p
        m2 = copy(m)
        m2[idx] = m[idx] + n
        dp[m2] = p[m] * 1/(factorial(m[idx] + n, m[idx]))
    end
    return dp
end

