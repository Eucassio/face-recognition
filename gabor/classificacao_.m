dir = '/media/OS/Users/EUCASSIO/Downloads/eucassiojr-face-recognition-56f4703fc1d7/eucassiojr-face-recognition-56f4703fc1d7/gabor/';

fileRead1 = strcat(dir,'hist_gabor_curvo_0.00_test2_crop_100_14_8x8_5x8_30x30.txt');
fileRead2 = strcat(dir,'hist_gabor_curvo_0.05_test2_crop_100_14_8x8_5x16_30x30.txt');
fileRead3 = strcat(dir,'hist_gabor_curvo_0.1_test2_crop_100_14_8x8_5x16_30x30.txt');
fileRead4 = strcat(dir,'hist_gabor_curvo_0.2_test2_crop_100_14_8x8_5x16_30x30.txt');
num=1000;

filesTrain = [
    sprintf('%-*s', num, fileRead1);
    sprintf('%-*s', num, fileRead2);
    sprintf('%-*s', num, fileRead3);
    sprintf('%-*s', num, fileRead4)
    ];

fileRead01 = strcat(dir,'hist_gabor_curvo_0.00_oclusao_100_12_8x8_5x8_30x30.txt');
fileRead02 = strcat(dir,'hist_gabor_curvo_0.05_oclusao_100_12_8x8_5x16_30x30.txt');
fileRead03 = strcat(dir,'hist_gabor_curvo_0.1_oclusao_100_12_8x8_5x16_30x30.txt');
fileRead04 = strcat(dir,'hist_gabor_curvo_0.2_oclusao_100_12_8x8_5x16_30x30.txt');

filesTest = [
    sprintf('%-*s', num, fileRead01);
    sprintf('%-*s', num, fileRead02);
    sprintf('%-*s', num, fileRead03);
    sprintf('%-*s', num, fileRead04)
    ];

    name = 'hist_gabor_curvo_TOTAL_HORIZ_test2_crop_100_14_8x8_5x16_30x30.txt';
    disp(name);
    [heart_scale_labeltreino, heart_scale_instreino] = libsvmread(name);
    heart_scale_instreino = full(heart_scale_instreino);
    %heart_scale_instreino=heart_scale_instreino(:,1:3:end);
    disp(size(heart_scale_instreino));
    
    name = 'hist_gabor_curvo_TOTAL_HORIZ_oclusao_100_12_8x8_5x16_30x30.txt';
    disp(name);
    [heart_scale_labelteste, heart_scale_insteste] = libsvmread(name);
    heart_scale_insteste = full(heart_scale_insteste);
    %heart_scale_insteste = heart_scale_insteste(:,1:3:end);
    disp(size(heart_scale_insteste));

%     ens = fitensemble(heart_scale_instreino,heart_scale_labeltreino,'AdaBoostM2',100,'Tree');
%     imp = predictorImportance(ens);
%     imp= logical(ceil(imp));
%     imp = repmat(imp,size(heart_scale_labeltreino,1),1);
%     heart_scale_instreino = heart_scale_instreino(imp);
%     heart_scale_instreinoRed = reshape(heart_scale_instreino,size(imp,1),nnz(imp(1,:)));
%     disp(size(heart_scale_instreinoRed));
%     
%     ens = fitensemble(heart_scale_insteste,heart_scale_labelteste,'AdaBoostM2',100,'Tree');
%     imp = predictorImportance(ens);
%     imp= logical(ceil(imp));
%     imp = repmat(imp,size(heart_scale_labelteste,1),1);
%     heart_scale_insteste = heart_scale_insteste(imp);
%     heart_scale_instesteRed = reshape(heart_scale_insteste,size(imp,1),nnz(imp(1,:)));
%     disp(size(heart_scale_instesteRed));
    
    subsets = [];
    subsetsTeste = [];
passo = 1000;
for j=0:passo:size(heart_scale_instreino,2)-passo
    

     disp(j+1);
     heart_scale_instreinoRed = heart_scale_instreino(:,j+1:j+passo);
     
%      ens = fitensemble(heart_scale_instreinoRed,heart_scale_labeltreino,'AdaBoostM2',100,'Tree');
%     imp = predictorImportance(ens);
%     imp= logical(ceil(imp));
%     imp = repmat(imp,size(heart_scale_labeltreino,1),1);
%     heart_scale_instreinoRed = heart_scale_instreinoRed(imp);
%     heart_scale_instreinoRed = reshape(heart_scale_instreinoRed,size(imp,1),nnz(imp(1,:)));
    

     [pc,score,latent,tsquare] = pca(heart_scale_instreinoRed);    
     heart_scale_instreinoRed = score(:,1:750);
    subsets = horzcat(subsets, heart_scale_instreinoRed);
    
    disp(size(heart_scale_instreinoRed));
    
    
    
     heart_scale_instesteRed = heart_scale_insteste(:,j+1:j+passo);
      [pc,score,latent,tsquare] = pca(heart_scale_instesteRed);    
     heart_scale_instesteRed = score(:,1:750);
    subsetsTeste = horzcat(subsetsTeste, heart_scale_instesteRed);
    disp(size(heart_scale_instesteRed));
% 
%     [pc,score,latent,tsquare] = pca(heart_scale_instreino);    
%     heart_scale_instreinoRed = score(:,1:j);
%     %heart_scale_instreinoRed = compute_mapping(heart_scale_instreino, 'LDA', j);
%     
%     disp(size(heart_scale_instreinoRed));
%     disp(size(heart_scale_labeltreino));
%     heart_scale_instreinoRed = sparse(heart_scale_instreinoRed);
%     disp('--------------------------------LIDO--------------------------------------');
%     
%     
%     name = strcat('hist_gabor_curvo_TOTAL_HORIZ_test2_crop_100_14_8x8_5x16_30x30_LDA_',num2str(j),'.txt');
%     libsvmwrite(name, heart_scale_labeltreino, heart_scale_instreinoRed);
%     
%     
%     disp(j);
%     
%     
%     [pc,score,latent,tsquare] = pca(heart_scale_insteste);
%     heart_scale_instesteRed = score(:,1:j);
%     %heart_scale_instesteRed = compute_mapping(heart_scale_insteste, 'LDA', j);
% 
%     disp(size(heart_scale_instesteRed));
%     disp(size(heart_scale_labelteste));
%     heart_scale_instesteRed = sparse(heart_scale_instesteRed);
%     disp('--------------------------------LIDO--------------------------------------');
    
    
    
%    name = strcat('hist_gabor_curvo_TOTAL_HORIZ_oclusao_100_12_8x8_5x16_30x30_PCA_',num2str(j), '.txt');
%    libsvmwrite(name, heart_scale_labelteste, heart_scale_instesteRed);
    
    %disp('treinando')
    %model = svmtrain(heart_scale_labeltreino, heart_scale_instreino);
    %disp('--------------------------------TREINADO--------------------------------------');
    %[predict_label, accuracy, dec_values] = svmpredict(heart_scale_labeltesteRed, heart_scale_instesteRed, model);
    %disp('--------------------------------PREDITO---------------------------------------');
    %fileID = fopen('resultado.txt','a');
   % rs =  strcat(num2str(accuracy), '_',num2str(j), '\n');
    %disp(rs)
    %fprintf(fileID,'%s',rs);
    %fclose(fileID);
   
end

    disp('treinando')
    disp(size(subsets));
    disp(size(subsetsTeste));
    model = svmtrain(heart_scale_labeltreino, subsets);
    disp('--------------------------------TREINADO--------------------------------------');
    [predict_label, accuracy, dec_values] = svmpredict(heart_scale_labelteste, subsetsTeste, model);
    disp('--------------------------------PREDITO---------------------------------------');
    %fileID = fopen('resultado.txt','a');
   % rs =  strcat(num2str(accuracy), '_',num2str(j), '\n');
    %disp(rs)
    %fprintf(fileID,'%s',rs);
    %fclose(fileID);
 disp('--------------------------------FIM--------------------------------------');