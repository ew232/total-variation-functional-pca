# total-variation-functional-pca
Comparison of total variation vs H1 penalty on eigenfunctions

Functional PCA extends principal component analysis to functional data of infinite dimensions.
Compared with traditional PCA, this takes into account the order of the dimensions from one time
point to next. The benefit over traditional principal component analysis is the flexibility of allowing
constraints to get what are desirable properties for the extracted principal component functions.
In image processing, images are functions in Sobolev space that can be denoised by penalizing the
norm of L operators on the image, e.g. image gradient or Laplacian. For this project, the goal is to
experiment with smoothness in the eigenfunctions from a set of images.
