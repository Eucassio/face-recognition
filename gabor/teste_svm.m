for i = 0: 0
    fileRead = strcat('hist_gabor_curvo_TOTAL_cacheco2_meiopi_4.txt');
    disp(fileRead);
    [heart_scale_label, heart_scale_inst] = libsvmread(fileRead);    
    disp('--------------------------------LIDO--------------------------------------');

end
    accuracy = svmtrain(heart_scale_label, heart_scale_inst, '-q -v 10');
    disp('--------------------------------TREINADO--------------------------------------');

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