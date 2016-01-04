%% Compactar imagens
% Compacta as imagens de um diretório específico
%% 

caminho = '/media/dados/facedatabase/AR_warp_zip/test2/';
outputPath = '/media/dados/facedatabase/ARface_48_56/';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.bmp'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
 cont =1;

for p = 1:numFrames

     name = [fileFolder '/' fileNames{p}];
     I2 = imread(name);      

     I2 =rgb2gray(I2);
     [x y] = size(I2);
     
     I2 = imcrop(I2,[0 24 y x-24]);
     I2 = imresize(I2, [56 NaN]);
     
     
     [people_name_tmp, imgIdx] = strtok(fileNames{p},'.');
     
     imwrite(I2, [outputPath '/' people_name_tmp '.png']);     
end

