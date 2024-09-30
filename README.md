# Spatiotemporal SVD Clutter Filtering for Super Reslution Ultrasound

Super resolution ultrasound is a non-ionizing imaging method that leverages microbubbles injected into the bloodstream as contrast agents to visually the internal structure of the body at superior resolution. Backscattered signal when the acoustic wave encounters a bubble allows for high frequency information to be received, allowing for the diffraction limit to be surpased.

| ![Raw super resolution ultrasound data](./Figures/1%20Unfiltered%20US/small/raw.gif) | ![Hilbert Transform](./Figures/1%20Unfiltered%20US/small/hilbert.gif) |
|:--:|:--:|
| **Figure 1**: Raw super resolution ultrasound data, 257 pixels in the x and z-directions for 150 acquisitions | **Figure 2**: Data after signal processing with Hilbert Transform |

To filter these images, Singular Value Decomposition (SVD) is used. First, the images are rearranged into a spatiotemporal (or Casorati) matrix where the rows correspond to a particular pixel in the image and the columns correspond to time. This rearrangement of spatiotemporal information allows for the left singular vectors to correspond to spatial singular vectors and the right singular vectors to correspond to temporal singular vectors. The singular values are organized in descending order of "contribution".  

By leveraging this rank-1 approximation of the outer products between the spatial and temporal singular vectors, weighed by the singular values, subspaces corresponding to tissue, vascular and noise can be reconstructed. High magnitude singular values correspond to low frequency information (aka tissue space), while low singular vectors correspond to high frequency information (aka noise space). By identifying the upper and lower bounds to the tissue and noise subspaces, a bandpass filter can be formed to isolate microbubble/vascular signal. 

| ![Reconstruction w/ 1:5 Singular Values](./Figures/2%20Arbitrary%20SVD/small/1-5.gif) | ![Reconstruction w/ 50:100 Singular Values](./Figures/2%20Arbitrary%20SVD/small/50-100.gif) | ![Reconstruction w/ 125:150 Singular Values](./Figures/2%20Arbitrary%20SVD/small/125-150.gif)
|:--:|:--:|:--:|
| **Figure 3**: Reconstruction with 1:5 singular values | **Figure 4**: Reconstruction with 50:100 singular values | **Figure 5**: Reconstruction with 125:150 singular values |

While this filtering can be conducted through trial and error in selection of these singular values, the spatial singular vectors can be used to conduct adaptive SVD filtering.

By calculating the correlation between the absolute value of the spatial singular vectors, an interesting correlation matrix can be generated. 

| ![Spatial Similarity Matrix](./Figures/3%20Spatial%20Similarity/small/ssm.png)
|:--:|
| **Figure 6**: Spatial similarity matrix, the correlation between the singular spatial vectors |

As my data is noisy, a less than ideal correlation matrix is generated. However, three squares should become evident in the correlation matrix. The top left square should correspond to the tissue subspace, where the singular spatial vectors corresponding to tissue have a high correlation. The middle square should correspond to the vascular subspace, where the singular spatial vectors corresponding to vascular have a high correlation. And the bottom right square should correspond to the noise subspace, where the singular spatial vectors corresponding to noise have a high correlation. 

Adaptive filtering can be conducted through this methodology, but data acquired in a refined matter is required to proceed.

| ![Reconstruction with 25:60 Singular Values](./Figures/4%20Singular%20Value%20Selection/small/25-60.gif)
|:--:|
| **Figure 7**: Reconstruction with 25:60 singular values |