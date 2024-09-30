using Plots
using Plots.PlotMeasures

export animate

function animate(images::AbstractArray,filename::String)
    pyplot()

    anim = @animate for i in axes(images,3)
        heatmap(images[:, :, i], title="Slice $i", 
        aspect_ratio=:equal, color=:viridis, colorbar=false, framestyle=:none, size=(800,800))
    end

    gif(anim, filename, fps=10)
end