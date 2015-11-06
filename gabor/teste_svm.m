% for i = 0: 0
%     fileRead = strcat('hist_concat_entropiaCroppedYale_crop_38_64_8x8_3x5_9x9.txt');
%     disp(fileRead);
%     [heart_scale_label, heart_scale_inst] = libsvmread(fileRead);    
%     disp('--------------------------------LIDO--------------------------------------');
% 
% end
%     accuracy = svmtrain(heart_scale_label, heart_scale_inst, '-q -v 10');
%     disp('--------------------------------TREINADO--------------------------------------');

  %heart%_scale_label = zeros(1400, 1);
%heart_scale_inst  = zeros(1400, 3600);
for i = 0: 0
    fileRead = strcat('hist_gabor_curvo_test2_crop_100_14_8x8_1x4_9x9.txt');
    disp(fileRead);
    [heart_scale_label, heart_scale_inst] = libsvmread(fileRead);    
    
    fileRead2 = strcat('hist_gabor_curvo_oclusao_100_12_8x8_1x4_9x9.txt');
    disp(fileRead2);
    [heart_scale_label2, heart_scale_inst2] = libsvmread(fileRead2); 
    
    disp('--------------------------------LIDO--------------------------------------');
  %  
    %heart_scale_label((i*280)+1 : 280*(i+1),:) = (i*10) + heart_scale_label_temp;
    %heart_scale_inst((i*280)+1 : 280*(i+1),:) = heart_scale_inst_temp;

    
end
    model = svmtrain(heart_scale_label, heart_scale_inst);
    disp('--------------------------------TREINADO--------------------------------------');
    [predict_label, accuracy, dec_values] = svmpredict(heart_scale_label2, heart_scale_inst2, model);
    disp('--------------------------------PREDITO---------------------------------------');
    %disp(predict_label);
    disp('--------------------------------FIM--------------------------------------');