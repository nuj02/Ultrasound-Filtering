using DSP

export signalProcess

function signalProcess(casorati::AbstractArray)

    # pad with zeros and apply hilbert transform columnwise
    padded = vcat(casorati',zeros(size(casorati')))
    Hc = hilbert(padded)
    # get envelope of signal
    Hc = abs.(Hc)

    dim = ndims(Hc)

    if(dim==1)
        Hc=Hc[1:div(size(Hc,1),2)];
    end
    if(dim==2)
        Hc=Hc[1:div(size(Hc, 1), 2),:];
    end
    if(dim==3)
        Hc=Hc[1:div(size(Hc, 1), 2),:,:];
    end
    if(dim==4)
        Hc=Hc[1:div(size(Hc, 1), 2),:,:,:];
    end

    Hc = 10 .* log10.(Hc')
    Hc = Hc .- maximum(Hc)
    
    return Hc
end