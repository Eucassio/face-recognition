function featureVector = gaborFeaturesHistEntropy(img,gaborArray,d1,d2, N, K,l2)

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


if (nargin ~= 7)    % Check correct number of arguments
    error('Use correct number of input arguments!')
end

if size(img,3) == 3	% % Check if the input image is grayscale
    img = rgb2gray(img);
end

img = double(img);


%% Filtering

% Filter input image by each Gabor filter
[u,v] = size(gaborArray);
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        gaborResult{i,j} = abs(conv2(img,gaborArray{i,j},'same'));        
    end
end


%% Feature Extraction

% chave � cell e parenteses � a matriz naquela posi��o da c�lula
% Faz a troca
[y,x] = size(img);
for i = 1:u
    for j = 1:v
        for a = 1:y
            for b = 1:x
                G{a,b}(i,j) = gaborResult{i,j}(a,b);
            end
        end
    end
end
        if(u >1) 
            for a = 1:y % Percorre a c�lula 512x512
                for b = 1:x
                    % recebe um valor de magnitude
                    % Normaliza��o da orienta��o
                    for i = 1:u % Percorre os valores de escala e orienta��o 2x3
                        for j = 1:v
                            % Normaliza��o da orienta��o
                            %norma = norm(G{a,b}(:,j));
                            G{a,b}(i,j) = G{a,b}(i,j)/norm(G{a,b}(:,j));
                        end
                    end
                end
            end
        end
        
        
        for a = 1:y % Percorre a c�lula 512x512
            for b = 1:x
                % recebe um valor de magnitude
                % Normaliza��o da orienta��o
                for i = 1:u % Percorre os valores de escala e orienta��o 2x3
                    for j = 1:v
                        % Supress�o n�o m�xima da escala
                       
                        if G{a,b}(i,j) == max(G{a,b}(i,:))
                            G{a,b}(i,j) = G{a,b}(i,j); 
                        else
                            G{a,b}(i,j) = 0;
                        end
                    end
                end
            end
        end
%% Monta os blocos
[row,col]=size(G);
% Valores dos blocos
aa = 1:N:row;
bb = 1:K:col;
[ii,jj] = ndgrid(aa,bb);
out = arrayfun(@(x,y) G(x:x+N-1,y:y+K-1),ii,jj,'un',0);
[row,col] = size(out);

%% Som�torios
n = 1;
sum1 = zeros(u,v);

c = 0;
for l = 1:row 
    for k = 1:col
        for a = 1:N % Percorre o bloco
            for b = 1:K
                % recebe um valor de magnitude
              
                        % Supress�o n�o m�xima da escala
                        if n == (N*K)+1
                            n = 1;
                            sum1 = zeros(u,v);
                        end
                            temp = cell2mat(out{l,k}(a,b));
                            sum1 = temp + sum1;                            
                            out1{l,k} = sum1;
                            n = n+1;                                 
            end
        end
       c = c+1;
        % Concatena a matriz e realiza o ultimo som�torio
       %soma = sum(out1{l,k},2);
       %soma2 = sum(soma);
       %out2(l,k) = soma2;
 
       
    end
end
out2 = cell2mat(out1);
result = cell(u,v);

for i = 1:col
    for j = 1:row
        for a = 1:u
            for b = 1:v
                result{a,b}(i,j) = out1{i,j}(a,b);
            end
        end
    end
end

C = out2(:);
C = C';


%H = reshape(H,row,col);
%H = mat2gray(H);
% imshow(H);
% 

featureVector = zeros(l2,1);
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
 c = 0;
 for i = 1:u
     for j = 1:v        
         c = c+1;
         %subplot(u,v,(i-1)*v+j)   
        %disp([int2str(i) ',' int2str(j)]);
        
        imgResult = mat2gray(result{i,j});
         %imshow(imgResult,[]);
        [img_h, img_v] = lvp_lee(imgResult,3);
        [z1,z2] = size(img_h);
        z1 = z1 * z2;
        
        gaborAbs = reshape(img_h,[],1);                
        
        % Normalized to zero mean and unit variance. (if not applicable, please comment this line)
        gaborAbs = (gaborAbs-mean(gaborAbs))/std(gaborAbs,1);
                     
        featureVector(((c-1)*z1+1):(c*z1)) = gaborAbs;
        c = c+1;
        
        gaborAbs = reshape(img_v,[],1);                
        % Normalized to zero mean and unit variance. (if not applicable, please comment this line)
        gaborAbs = (gaborAbs-mean(gaborAbs))/std(gaborAbs,1);
        
        featureVector(((c-1)*z1+1):(c*z1)) = gaborAbs;
        
%         figure
%         subplot(1,2,1), imshow(img_h);
%         subplot(1,2,2), imshow(img_v);
        
     end
 end
 
 l1norm = norm(featureVector, 1);
H = featureVector/l1norm;
featureVector = H;

