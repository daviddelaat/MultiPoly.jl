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

function evaluate_basis{T}(p::MPoly{T}, es...)
    r = Array(T, 0)
    for (m, c) in p
        r1 = c
        for i = 1:length(m)
            r1 *= es[i]^m[i]
        end
        push!(r, r1)
    end
    r
end
