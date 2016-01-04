caminho = '/media/dados/mestrado/face-recognition/gabor/resultados';
output =  '/media/dados/mestrado/face-recognition/gabor/concatenado/';

fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.txt'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
cont =1;

heart_scale_instreino=[];
heart_scale_labeltreino=[];
heart_scale_insteste=[];
heart_scale_labelteste=[];
clearvars heart_scale_inst1 heart_scale_label1 red_dim;

for p = 1:numFrames
    
    name = [fileFolder '/' fileNames{p}];
    disp(name);
    [heart_scale_label1, heart_scale_inst1] = libsvmread(name);
    movefile(name, [fileFolder '/processados/03012016/' fileNames{p}]);
    
    heart_scale_instreino = horzcat(heart_scale_instreino,heart_scale_inst1);
    if(mod(p,4) == 0)
        name = [output fileNames{p}(1:size(fileNames{p},2)-4), '_concatenado.txt'];
        
        disp(['Concatenando ...' name]);
        libsvmwrite(name, heart_scale_label1, sparse(heart_scale_instreino));        
        
        heart_scale_instreino=[];
        heart_scale_labeltreino=[];
        heart_scale_insteste=[];
        heart_scale_labelteste=[];
        clearvars heart_scale_inst1 heart_scale_label1 red_dim;
    end
end
