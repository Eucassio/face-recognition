%% Compactar imagens
% Compacta as imagens de um diretório específico
%% 

caminho = '/media/dados/facedatabase/Feret_faces/';
outputPath = '/media/dados/facedatabase/Feret_faces/crop';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
 cont =1;

for p = 1:numFrames

     name = [fileFolder '/' fileNames{p}];
     I2 = imread(name);      

     %I2 =rgb2gray(I2);
     [x y] = size(I2);
     
     I2 = imresize(I2, [56 NaN]);
     I2 = imcrop(I2,[7 0 47 56]);
     
     [people_name_tmp, imgIdx] = strtok(fileNames{p},'.');
     
     imwrite(I2, [outputPath '/' people_name_tmp '.png']);     
end

