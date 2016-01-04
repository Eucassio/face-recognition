caminho =  '/media/dados/mestrado/face-recognition/gabor/concatenado';

fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.txt'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
cont =1;

for p = 1:numFrames
    
    name = [fileFolder '/' fileNames{p}];
    disp(name);
    [heart_scale_label, heart_scale_inst] = libsvmread(name);
    disp('--------------------------------TREINANDO--------------------------------------')
    accuracy = svmtrain(heart_scale_label, heart_scale_inst, '-q -v 10');
    disp('--------------------------------TREINADO--------------------------------------')
    
    fileID = fopen('concatenado/resultados.txt','a');
    
    rs = regexp(fileNames{p}, '(?<=_).*?(?=_)', 'match');
    fileInfo = dir(name);
    
    fileSize = fileInfo.bytes/1024/1024;
    
    fprintf(fileID,'\n%s\t%s\t%8.5f\t%s\t%s\t%8.5f\t%d\t%s\t%s\t%s\t%s\t%s\t%s','Gabor e entropia', rs{11}, accuracy ,rs{4}, rs{7},fileSize, size(heart_scale_inst,2), rs{9}, rs{10}, rs{12}, rs{13});
    fclose(fileID);
end

%heart%_scale_label = zeros(1400, 1);
%heart_scale_inst  = zeros(1400, 3600);
% for i = 0: 0
%     fileRead = strcat('hist_gabor_curvo_PCA4_0.2_Arface_100_14_8x8_5x16_30x30.txt_concat.libsvm_final_4500.txt');
%     disp(fileRead);
%     [heart_scale_label, heart_scale_inst] = libsvmread(fileRead);
%
%     fileRead2 = strcat('hist_gabor_curvo_PCA5_0.2_oclusao_100_12_8x8_5x16_30x30.txt_concat.libsvm_final_4500.txt');
%     disp(fileRead2);
%     [heart_scale_label2, heart_scale_inst2] = libsvmread(fileRead2);
%
%     disp('--------------------------------LIDO--------------------------------------');
%
%     %heart_scale_label(1001 : 2000,:) =  heart_scale_label_temp;
%     %heart_scale_inst((i*280)+1 : 280*(i+1),:) = heart_scale_inst_temp;
%
%
% end
%     model = svmtrain(heart_scale_label, heart_scale_inst);
%     disp('--------------------------------TREINADO--------------------------------------');
%     [predict_label, accuracy, dec_values] = svmpredict(heart_scale_label2, heart_scale_inst2, model);
%     disp('--------------------------------PREDITO---------------------------------------');
%     %disp(predict_label);
%     disp('--------------------------------FIM--------------------------------------');