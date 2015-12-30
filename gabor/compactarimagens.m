%% Compactar imagens
% Compacta as imagens de um diretório específico
%% 

caminho = 'E:\facedatabase\AR_warp_zip\test2';
outputPath = 'E:\facedatabase\AR_warp_zip\ARface';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.bmp'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
 cont =1;

for p = 1:numFrames

     name = [fileFolder '/' fileNames{p}];
     I2 = imread(name);      

     I2 =rgb2gray(I2);
     I2 = imcrop(I2,[10 34  102 135]);
     I2 = imresize(I2, [56 NaN]);
     
     [people_name_tmp, imgIdx] = strtok(fileNames{p},'.');
     
     imwrite(I2, [outputPath '\' people_name_tmp '.png']);     
end

