using LinearAlgebra

export stFilter

function stFilter(casoratiMat::AbstractArray,a::Integer,b::Integer)

    U, S, V = svd(casoratiMat)
    filteredMat = U[:,a:b] * Diagonal(S[a:b]) * V'[a:b, :]

    return filteredMat
end