function +(ps::MPoly...)
    pu = PolyUnion(ps)
    r = zero(pu)
    for pindex = 1:length(ps)
        for (m, c) in ps[pindex]
            r[newexps(pu, m, pindex)] += c
        end
    end
    r
end

function +(p1::MPoly, p2::MPoly)
    pu = PolyUnion([p1, p2])
    r = zero(pu)
    for (m, c) in p1
        r[newexps(pu, m, 1)] += c
    end
    for (m, c) in p2
        r[newexps(pu, m, 2)] += c
    end
    r
end

function +{T,U}(p::MPoly{T}, s::U)
    r = copy(convert(MPoly{promote_type(T,U)}, p))
    r[zeros(Int, nvars(p))] += s
    r
end

+(s, p::MPoly) = p + s


function -(p::MPoly, q::MPoly)
    pu = PolyUnion([p, q])
    r = zero(pu)
    for (m, c) in p
        r[newexps(pu, m, 1)] += c
    end
    for (m, c) in q
        r[newexps(pu, m, 2)] -= c
    end
    r
end

function -{T,U}(p::MPoly{T}, s::U)
    r = copy(convert(MPoly{promote_type(T, U)}, p))
    r[zeros(Int, nvars(p))] -= s
    r
end

function -(p::MPoly)
    r = zero(p)
    for (m, c) in p
        r[m] = -c
    end
    r
end

-(s, p::MPoly) = -p + s


function *(p1::MPoly, p2::MPoly)
    pu = PolyUnion([p1, p2])
    r = zero(pu)
    for (m1, c1) in p1
        for (m2, c2) in p2
            r[newexps(pu, m1, 1) + newexps(pu, m2, 2)] += c1 * c2
        end
    end
    r
end

function *{T,U}(s::T, p::MPoly{U})
    r = zero(MPoly{promote_type(T,U)}, vars=vars(p))
    for (m, c) in p
        r[m] = s * c
    end
    r
end

*(p::MPoly, s) = s * p


function ^(p::MPoly, power::Integer)
    @assert power >= 0
    if power == 0
        return one(p)
    elseif power == 1
        return p
    else
        f, r = divrem(power, 2)
        return p^(f+r) * p^f
    end
end


function /{T,U}(p::MPoly{T}, s::U)
    r = zero(MPoly{promote_type(T,U)}, vars=vars(p))
    for (m, c) in p
        r[m] = c/s
    end
    r
end


function conj(p::MPoly)
    r = zero(p)
    for (m, c) in p
        r[m] = conj(c)
    end
    r
end


function real{T<:Real}(p::MPoly{Complex{T}})
    r = zero(MPoly{T}, vars=vars(p))
    for (m, c) in p
        r[m] = real(c)
    end
    r
end

real{T<:Real}(p::MPoly{T}) = p

function imag{T<:Real}(p::MPoly{Complex{T}})
    r = zero(MPoly{T}, vars=vars(p))
    for (m, c) in p
        r[m] = imag(c)
    end
    r
end

imag{T<:Real}(p::MPoly{T}) = zero(p)
