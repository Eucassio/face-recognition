dir = '';

heart_scale_instreino=[];
heart_scale_labeltreino=[];


name = 'hist_gabor_curvo_PCA2_0.2_yale_38_10_8x8_5x16_30x30.txt_concat.txt';
%name = 'hist_gabor_curvo_PCA4_0.2_Arface_100_14_8x8_5x16_30x30.txt_concat.libsvm';
[heart_scale_labeltreino, heart_scale_inst1] = libsvmread(name);
heart_scale_inst1 = full(heart_scale_inst1);

[dx, dy] = size(heart_scale_inst1);

tamx = 4;
tam = dy/tamx;
treinoRed = zeros(dx, dy/8);

for i = 1:dx
    %disp(i);
    pcaRec =[];
    z = reshape(heart_scale_inst1(i,1:tam),105,[]);
    zz1 = mat2cell(z, repmat(5,1,21),repmat(4,1,21));
 
    z = reshape(heart_scale_inst1(i,tam+1:tam*2),105,[]);
    zz2 = mat2cell(z, repmat(5,1,21),repmat(4,1,21));
 
    z = reshape(heart_scale_inst1(i,tam*2+1:tam*3),105,[]);
    zz3 = mat2cell(z, repmat(5,1,21),repmat(4,1,21));
  
    z = reshape(heart_scale_inst1(i,tam*3+1:tam*4),105,[]);
    zz4 = mat2cell(z, repmat(5,1,21),repmat(4,1,21));
    
    [x, y] = size(zz1);
    
    for a = 1:y % Percorre a c�lula 512x512
        for b = 1:x
            pcaRec = horzcat(zz1{a,b},zz2{a,b},zz3{a,b},zz4{a,b});
            [coeff,score,latent] = pca(pcaRec);
            G3{a,b} = score(:,1:2);
        end
    end
    
    
    out2 = cell2mat(G3);
    C = out2(:);
    C = C';
    treinoRed(i,1: dy/8) = C;
end


libsvmwrite([name '_final_' num2str(tam) '.txt'], heart_scale_labeltreino, sparse(treinoRed));
disp('Fim')
