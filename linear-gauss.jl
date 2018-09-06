function checkInputs(a::Array{Float64, 2}, x::Array{Float64, 2}, b::Array{Float64, 2})
    if (ndims(a) = 2 && size(a)[1] == size(a)[2])
        return true
    else
        return false
    end
end

function triangularize(a::Array{Float64, 2}, x::Array{Float64, 1}, b::Array{Float64, 1})
    for k = 1:size(a, 1) - 1
        for i = k + 1:size(a, 1)
            multiplier = a[i, k] / a[k, k]

            a[i, k] = 0.0
            for j = k + 1:size(a, 1)
                a[i, j] = a[i, j] - multiplier * a[k, j]
            end
            b[i] = b[i] - multiplier * b[k]
        end
    end
end

function findBestPivot(a::Array{Float64, 2}, b::Array{Float64, 1}, collum::Int64, k::Int64)
    min = 0
    max = 0
    index_max = k
    index_min = k

    for i = k:size(a, 1)
        if (a[i, collum] > max)
            max = a[i, collum]
            index_max = i
        elseif (a[i, collum] < min)
            min = a[i, collum]
            index_min = i
        end
    end


    if abs(max) > abs(min)
        temp = a[k,:]
        a[k,:] = a[index_max,:]
        a[index_max,:] = temp

        b_temp = b[k]
        b[k] = b[index_max]
        b[index_max] = b_temp
    else # abs(max) <= abs(min)
        temp = a[k,:]
        a[k,:] = a[index_min,:]
        a[index_min,:] = temp

        b_temp = b[k]
        b[k] = b[index_min]
        b[index_min] = b_temp
    end
end

function solveSystem(a::Array{Float64, 2}, x::Array{Float64, 1}, b::Array{Float64, 1})
    x[size(x, 1)] = b[size(b, 1)] / a[size(a, 1), size(a, 1)]

    for k = size(a, 1) - 1:-1:1
        s = 0
        for j = k + 1:size(a, 1)
            s = s + a[k, j]*x[j]
        end

        x[k] = (b[k] - s) / a[k, k]
    end
end
