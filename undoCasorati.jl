export undoCasorati

function undoCasorati(casoratiMat)
    dims = size(casoratiMat);
    newDim = Int(sqrt(dims[1]))
    return reshape(filteredMat, newDim, newDim, dims[2])
end