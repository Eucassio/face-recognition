function featureVector = gaborFeaturesHistGPU2(img,gaborArray,d1,d2, N, K)

% GABORFEATURES extracts the Gabor features of the image.
% It creates a column vector, consisting of the image's Gabor features.
% The feature vectors are normalized to zero mean and unit variance.
%
%
% Inputs:
%       img         :	Matrix of the input image
%       gaborArray	:	Gabor filters bank created by the function gaborFilterBank
%       d1          :	The factor of downsampling along rows.
%                       d1 must be a factor of n if n is the number of rows in img.
%       d2          :	The factor of downsampling along columns.
%                       d2 must be a factor of m if m is the number of columns in img.
%
% Output:
%       featureVector	:   A column vector with length (m*n*u*v)/(d1*d2).
%                           This vector is the Gabor feature vector of an
%                           m by n image. u is the number of scales and
%                           v is the number of orientations in 'gaborArray'.
%
%
% Sample use:
%
% img = imread('cameraman.tif');
% gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
% featureVector = gaborFeatures(img,gaborArray,4,4);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.
%
%
%   Details can be found in:
%
%   M. Haghighat, S. Zonouz, M. Abdel-Mottaleb, "Identification Using
%   Encrypted Biometrics," Computer Analysis of Images and Patterns,
%   Springer Berlin Heidelberg, pp. 440-448, 2013.
%
%
% (C)	Mohammad Haghighat, University of Miami
%       haghighat@ieee.org
%       I WILL APPRECIATE IF YOU CITE OUR PAPER IN YOUR WORK.


if (nargin ~= 6)    % Check correct number of arguments
    error('Use correct number of input arguments!')
end

if size(img,3) == 3	% % Check if the input image is grayscale
    img = rgb2gray(img);
end

img = double(img);


%% Filtering

% Filter input image by each Gabor filter
[u,v] = size(gaborArray);
[y,x] = size(img);

 gaborResult = l1(img,gaborArray,u,v,x,y);
gArray  = cell2mat(gaborResult);

[G, G2] = l2(gArray,u,v,x,y);


G3 = cell(x,y);

 for a = 1:y % Percorre a c�lula 512x512
        for b = 1:x
            [coeff,score,latent] = pca(G2{a,b});
            G3{a,b} = score(:,1:4);
        end
 end
%disp(isequal(G,G2));

%% Feature Extraction
G = l3(G3,u,v,x,y);


%G = arrayfun(@l31,G,u,v,x,y);
G = l4(G,u,v,x,y);
%% Monta os blocos

out = l5(G,N,K);
[row,col] = size(out);

%% Som�torios
out1 = l6(out,u,v,row,col,K,N);
out2 = cell2mat(out1);
C = out2(:);
C = C';

l1norm = norm(C, 1);
H = C/l1norm;
featureVector = H;
%H = mat2gray(H);
% imshow(H);
%
%  figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
%  for i = 1:u
%      for j = 1:v
%          subplot(u,v,(i-1)*v+j)
%         disp([int2str(i) ',' int2str(j)]);
%
%          imshow(gaborResult{i,j},[]);
%
%      end
%  end

