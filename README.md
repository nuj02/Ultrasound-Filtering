# Spatiotemporal SVD Clutter Filtering for Super Reslution Ultrasound

## Background
Ultrasound is often the most desirable method for patients to image the internal structures of the human body as it is non-ionizing with low tradeoff between spatial and temporal resolution. 

To compete with the spatial resolution provided by other ionizing medical imaging modalities, super resolution ultrasound (SRUS) leverages microbubble contrast agents injected into the bloodstream. These microbubbles produce a backscattered signal when the acoustic wave encounters a microbubble, allowing for higher frequency information to be received by the ultrasound transducer resulting in a more-resolved image.

| ![Raw super resolution ultrasound data](./Figures/1%20Unfiltered%20US/small/raw.gif) | ![Hilbert Transform](./Figures/1%20Unfiltered%20US/small/hilbert.gif) |
|:--:|:--:|
| **Figure 1**: Raw super resolution ultrasound data, 257 pixels in the x and z-directions for 150 acquisitions | **Figure 2**: Data after signal processing with the Hilbert Transform |

## SRUS Filtering
To filter these images, Singular Value Decomposition (SVD) is used. First, the images are rearranged into a spatiotemporal (or Casorati) matrix where the rows correspond to a pixel in the image and the columns correspond to time. This rearrangement of spatiotemporal information allows for the left singular vectors to correspond to spatial singular vectors and the right singular vectors to correspond to temporal singular vectors. The singular values are organized in descending order of "contribution".  

By leveraging this rank-1 approximation of the outer products between the spatial, temporal singular vectors and weighed by the singular values, subspaces corresponding to tissue, vascular and noise can be reconstructed. High magnitude singular values correspond to low frequency information (aka tissue space), while low singular vectors correspond to high frequency information (aka noise space). By identifying the upper and lower bounds to the tissue and noise subspaces, a bandpass filter can be formed to isolate microbubble/vascular signal. 

| ![Reconstruction w/ 1:5 Singular Values](./Figures/2%20Arbitrary%20SVD/small/1-5.gif) | ![Reconstruction w/ 50:100 Singular Values](./Figures/2%20Arbitrary%20SVD/small/50-100.gif) | ![Reconstruction w/ 125:150 Singular Values](./Figures/2%20Arbitrary%20SVD/small/125-150.gif)
|:--:|:--:|:--:|
| **Figure 3**: Reconstruction with 1:5 singular values | **Figure 4**: Reconstruction with 50:100 singular values | **Figure 5**: Reconstruction with 125:150 singular values |

## Adaptive SRUS Filtering
While this filtering can be conducted through trial and error in selection of these singular values, the spatial singular vectors can be used to conduct adaptive SVD filtering.

By calculating the correlation between the absolute value of the spatial singular vectors, an interesting correlation matrix can be generated. 

| ![Spatial Similarity Matrix](./Figures/3%20Spatial%20Similarity/small/ssm.png) | ![Reconstruction with 25:60 Singular Values](./Figures/4%20Singular%20Value%20Selection/small/25-60.gif)
|:--:|:--:|
| **Figure 6**: Spatial similarity matrix, the correlation between the singular spatial vectors | **Figure 7**: Reconstruction with 25:60 singular values 

As my data is noisy, a less than ideal correlation matrix is generated. However, three squares become evident in the correlation matrix. The top left square corresponds to the tissue subspace, where the singular spatial vectors corresponding to tissue have a high correlation. The middle square corresponds to the vascular subspace, where the singular spatial vectors corresponding to vascular information have a high correlation. And the bottom right square should correspond to the noise subspace, where the singular spatial vectors corresponding to noise have a high correlation. 

Adaptive filtering can be conducted through this methodology. 

## Overview
Filtering of Super Resolution Ultrasound Images can be conducted by leveraging a spatiotemporal rearrangement of the acquisition data by which SVD can be applied to.  Correlation between the spatial singular vectors can then be used to conduct adaptive filtering of the imaging data. 