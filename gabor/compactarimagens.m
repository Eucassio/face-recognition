%% Compactar imagens
% Compacta as imagens de um diretório específico
%% 

caminho = '/home/eucassio/projetos/mestrado/processamento de imagens/gabor/feret_front_full_6/';
outputPath = '/home/eucassio/projetos/mestrado/fei_crop';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.jpg'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
 cont =1;

for p = 1:numFrames

     name = [fileFolder '/' fileNames{p}];
     I2 = imread(name);      

     %I2 =rgb2gray(I2);
     I2 = imresize(I2,[210 210]);
     imwrite(I2, name);     
end

