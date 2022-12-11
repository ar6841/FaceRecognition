close all
clear all
clc

%% User input

image_name = input('Enter image name, PLEASE ADD .jpg or .bmp: ','s');

input_image = imread(append('Face dataset\Testing\',image_name));

%% Start timer
tic

%% Read the images in training set
TrainingDatastore = imageDatastore('Face dataset\Training\');
M = length(TrainingDatastore.Files); % Number of images
for i=1:M
    training_images(:,:,i) = imread(TrainingDatastore.Files{i,1});
end
rows = size(training_images,1);
cols = size(training_images,2);
N = rows*cols;
%% Calculate column vector meanface m

avg_matrix_m = sum(training_images,3)/M; % Add up all the NxN images and divide by number of images

m =zeros(N,1); %Preallocate for efficiency
for i=1:rows
    m(cols*(i-1)+1:cols*i,1)=avg_matrix_m(i,:)'; %stacking the rows as coulmn vectors
end


%% Create column vector of training images R
R = zeros(N, M); %Preallocate memory for efficiency
for i = 1:M
    for j=1:rows
        R(cols*(j-1)+1:cols*j,i)=training_images(j,:,i)'; %stacking the rows for each image as a column vectors together in one matrix
    end 
end

%% Shift of center (Make each column vector centered at mean face)

A = R-m;

%% M largest Eigenvalues of C=A*A'
% This is a bit of linear algebra magic to find the M largest eignevalues and
% eigenvectors of the matrix A*A'

L = A'*A;
[V,D] = eig(L);

U = A*V; %Eigen face space

%% Eigenface coefficients

omega_full = U'*A;


%% Reshape input image
I =zeros(N,1); %Preallocate for efficiency
for i=1:rows
    I(cols*(i-1)+1:cols*i,1)=input_image(i,:)'; %stacking the rows as coulmn vector
end

I = I-m; %Shift of center for input image

%% Compute its projection onto face space to obtain eigenface coefficients
omega_I = U'*I;

%% Check which training image has least distance with input image

distances = zeros(1,M); %Preallocate for efficiency
least_dist = inf;
least_dist_index = 0;
for i = 1:M
    distances(i) = euclid_distance(omega_I,omega_full(:,i));
    if(distances(i) < least_dist)
        least_dist = distances(i);
        least_dist_index = i;
    end
end
%% Saving the mean face as .jpg
avg_matrix_m = uint8(round(avg_matrix_m));
imwrite(avg_matrix_m, "Face dataset\MeanFace.jpg");

%% Save the eigen faces
eignFace = zeros(rows,cols); %Prealloca for efficiency 
for i=1:M
    for j = 1:rows
        eignFace(j,:) = U(cols*(j-1)+1:cols*j,i); %reshape column vector to rows*cols
    end
    eignFace = uint8(round(eignFace));
    imwrite(eignFace,"Face dataset\EigenFaces\"+ string(i)+ ".jpg");
end
toc
%% Open the least distance training image and input image (These are the outputs)
f1 = figure;
imshow(input_image)
title( 'Input image')
disp('Input image Eigen face coefficients = ');
fprintf('%d\n',omega_I) % Print the eigen coefficients of input image


f2 = figure;

%splits = split(TrainingDatastore.Files{least_dist_index,1},'\'); %split the matched image path
%recognized_name = splits{end}; %training image matched name

imshow(TrainingDatastore.Files{least_dist_index,1}); %show matched image
title(append('Matched image in training dataset'));

%% Euclidian distance function
function dist = euclid_distance(x1,x2)

    if(length(x1) ~= length(x2) )
        error('Vecor dimensions are not compatible');
    else
        n = length(x1);
        v = (x1-x2).^2;
        sum =  0;
        for i = 1:n
            sum = sum+v(i);
        end
        dist = sqrt(sum);
    end

end