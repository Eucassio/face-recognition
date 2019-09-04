caminho = '/home/eucassio/desenvolvimento/projetos/pessoal/face-recognition/Results/featuresvector/';
output =  '/home/eucassio/desenvolvimento/projetos/pessoal/face-recognition/Results/featuresvector/concatenated/';

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
    movefile(name, [fileFolder '/processed/03092019/' fileNames{p}]);
    
    heart_scale_instreino = horzcat(heart_scale_instreino,heart_scale_inst1);
    if(mod(p,4) == 0)
        name = [output fileNames{p}(1:size(fileNames{p},2)-4), '_concatenated.txt'];
        
        disp(['Concatenating ...' name]);
        libsvmwrite(name, heart_scale_label1, sparse(heart_scale_instreino));        
        
        heart_scale_instreino=[];
        heart_scale_labeltreino=[];
        heart_scale_insteste=[];
        heart_scale_labelteste=[];
        clearvars heart_scale_inst1 heart_scale_label1 red_dim;
    end
end
