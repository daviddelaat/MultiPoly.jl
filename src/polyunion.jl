struct PolyUnion
    vars::Vector{Symbol}
    mat::Array{Int, 2}
    eltype::Type
end

function PolyUnion(ps)
    newvars = isempty(ps) ? [] : union([vars(p) for p in ps]...)
    mat = Array{Int}(undef, length(newvars), length(ps))
    for pindex = 1:length(ps)
        for i = 1:length(newvars)
            mat[i, pindex] = something(findfirst(isequal(newvars[i]), vars(ps[pindex])), 0)
        end
    end
    PolyUnion(newvars, mat, promote_type([eltype(p) for p in ps]...))
end

eltype(pu::PolyUnion) = pu.eltype

vars(pu::PolyUnion) = pu.vars

nvars(pu::PolyUnion) = length(vars(pu))

newexps(pu::PolyUnion, exps::Vector{Int}, polindex::Int) =
    [pu.mat[i, polindex] == 0 ? 0 : exps[pu.mat[i, polindex]] for i = 1:nvars(pu)]

function oldexps(pu::PolyUnion, exps::Vector{Int}, polindex::Integer)
    v = zeros(Int, length(exps))
    l = 0
    for i = 1:length(exps)
        t = pu.mat[i, polindex]
        if t != 0
            v[t] = exps[i]
            l += 1
        end
    end
    v[1:l]
end    
    
zero(pu::PolyUnion) = zero(MPoly{eltype(pu)}, vars=vars(pu))

one(pu::PolyUnion) = one(MPoly{eltype(pu)}, vars=vars(pu))
