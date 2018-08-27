function evaluate(p::MPoly{T}, es...) where {T}
    r = zero(T)
    for (m, c) in p
        t = c
        for i = 1:length(m)
            t *= es[i]^m[i]
        end
        r += t
    end
    r
end

function evaluate_basis(p::MPoly{T}, es...) where {T}
    r = Array{T}(undef, 0)
    for (m, c) in p
        r1 = c
        for i = 1:length(m)
            r1 *= es[i]^m[i]
        end
        push!(r, r1)
    end
    r
end
