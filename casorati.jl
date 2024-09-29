export casorati, undoCasorati

function casorati(image::AbstractArray)
    return reshape(image, size(image,1) * size(image,2), size(image,3))
end

export undoCasorati

function undoCasorati(casoratiMat)
    dims = size(casoratiMat);
    newDim = Int(sqrt(dims[1]))
    
    return reshape(casoratiMat, newDim, newDim, dims[2])
end