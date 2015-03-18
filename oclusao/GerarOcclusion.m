clc;
clear;
%criando cell para guardas as imagens
caminho = '/home/eucassio/projetos/mestrado/Faces/occlusion/';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.jpg'));
fileNames = {dirOutput.name}';
numImages = numel(fileNames);

 for i = 1 : numImages
     file = [caminho '/' fileNames{i}];
     I = imread(file);
     I = Occlusion(I);
     imwrite(I, file);
 end