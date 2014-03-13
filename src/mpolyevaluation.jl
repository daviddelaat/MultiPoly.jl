function evaluate{T}(p::MPoly{T}, es...)
    r = zero(MPoly{T})
    for (m, c) in p
        t = c * one(MPoly{T})
        for i = 1:length(m)
            t *= es[i]^m[i]
        end
        r += t
    end
    r
end
