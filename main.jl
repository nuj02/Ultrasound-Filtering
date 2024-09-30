using Revise
using MAT

include("./scripts/signal_process.jl")
include("./scripts/casorati.jl")
include("./scripts/spatiotemporal_filter.jl")
include("./scripts/spatial_singularity.jl")
include("./scripts/visualize.jl")

# Read file
matfile = matread("./bfRFC.mat");
A = matfile["bfRFC"];

# convert to Casorati Matrix
A = casorati(A[:,:,1:150]);

# band-pass spatiotemporal filtering
A = stFilter(A,50,100);

# spatial similarity matrix
# A = ssm(A);

# heatmap(A, title="Spatial Similarity Matrix", 
#         aspect_ratio=:equal, color=:viridis, colorbar=false, size=(800,800), yflip=true)

# post-processing with Hilbert Transform
A = signalProcess(A);

# convert back
A = undoCasorati(A);

animate(A, "animation.gif");