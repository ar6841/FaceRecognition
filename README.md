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

## Instructions

1) To run the program, add folder containing "EigenFaceRec.m”  and “Face Dataset” to the MATLAB path

2) Run "EigenFaceRec.m”

3) Enter the input image name in the MATLAB command line, add the “.jpg” or “.bmp” at the end

4) The command line will output the input image Eigenface coefficients $\overrightarrow{\Omega}_i$

5) Wait for the script to display all the relevant image outputs in order

6) If the name of the file was entered incorrectly, re-run the program

# Outputs

![image](https://user-images.githubusercontent.com/96152967/206932661-faaa7823-8930-4c80-a3e8-970b58ca5fd5.png)

![image](https://user-images.githubusercontent.com/96152967/206932685-46f56d8c-1fc7-4185-8787-746448d3b6d6.png)

![image](https://user-images.githubusercontent.com/96152967/206932709-79859c2f-b033-436d-ae41-a18da78d5d38.png)






# Notes
Although this training dataset contains faces, the algorithm is much more abstract and can be used for recognizing any object as long as lighting, scale and translation, and a highly controlled environment are maintained
