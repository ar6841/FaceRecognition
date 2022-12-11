# FaceRecognition
A fast face recognition algorithm that uses Eigen Face training to recognize an input image.

## Method used

### 1. Training: 
Principle Component Analysis (PCA) is applied to a set of training face images contained in 'FaceDataset/Training/' and the largest eigenvalues with their eigenvectors (eigenfaces) are used to represent the face space

### 2. Representation: 
A face image (including unseen faces) can then be projected onto the face space and represented by a set of PCA coefficients. 
### 3. Reconstruction:
Using the PCA coefficients as weights, we can reconstruct the original face image using a linear combination of the eigenfaces (eigenvectors.)
### 4. Matching: 
Matching is done by computing the distance between the PCA coefficients of two faces.


# Notes
Although this training dataset contains faces, the algorithm is much more abstract and can be used for recognizing any object as long as lighting, scale and translation, and a highly controlled environment are maintained
