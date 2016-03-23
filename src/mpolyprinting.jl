function show(io::IO, p::MPoly)
    print(io, typeof(p))
    print(io, '(')
    print(io, p)
    print(io, ')')
end

function printmonomial(io::IO, m, vars)
    first = true
    for i = 1:length(m)
        if m[i] >= 1 || m[i] <= -1
            if first
                first = false
            else
                print(io, '*')
            end
            print(io, vars[i])
            if m[i] >= 2 || m[i] <= -1
                print(io, '^')
                print(io, m[i] > 0 ? m[i] : "($(m[i]))")
            end
        end
    end
end

function print{T}(io::IO, p::MPoly{T})
    first = true
    for (m, c) in p
        if first
            if T <: Complex
                if m == zeros(Int, length(m))
                    print(io, "$c")
                else
                    print(io, "($c)*")
                end
            else
                if m == zeros(Int, length(m)) || c != one(T)
                    print(io, c)
                end
            end
            printmonomial(io, m, vars(p))
            first = false
        else
            if T <: Complex
                if m == zeros(Int, length(m))
                    print(io, " + $c")
                else
                    print(io, " + ($c)*")
                end
            else
                if c >= zero(T)
                    if m != zeros(Int, length(m)) && c == one(T)
                        print(io, " + ")
                    else
                        print(io, " + $c")
                    end
                else
                    print(io, " - $(-c)")
                end
            end
            printmonomial(io, m, vars(p))
        end
    end
    if first
        print(io, zero(T))
    end
end

showcompact(io::IO, p::MPoly) = print(io, p)
