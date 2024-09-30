export ssm

using Statistics

function ssm(casorati::AbstractArray)
    U, S, V = svd(casorati)

    nxz = size(U,1)

    U_norm = 1/nxz * (abs.(U) .- abs.(mean(U,dims=1))) ./ std(U,dims=1)

    return U_norm' * U_norm
end