dir = '';

heart_scale_instreino=[];
heart_scale_labeltreino=[];


name = 'hist_gabor_curvo_TOTAL_cacheco2_4.txt';
%name = 'hist_gabor_curvo_PCA4_0.2_Arface_100_14_8x8_5x16_30x30.txt_concat.libsvm';
[heart_scale_labeltreino, heart_scale_inst1] = libsvmread(name);
heart_scale_inst1 = full(heart_scale_inst1);

[dx, dy] = size(heart_scale_inst1);

tamx = 4;
tam1 = dy/4;%tamanho do vetor de caracteristicas para cada variação de c
tam2 = tam1;%tamanho do vetor de caracteristicas para cada variação de c
treinoRed = zeros(dx, dy/8);
numFrequencias = 5;
tamBlocoX = 44/4; %largura da imagem/tamanho do bloco
tamBlocoY = 56/4; %comprimento da imagem/tamanho do bloco

tamReshape = numFrequencias*tamBlocoX; %numero de frequencias * tamBloco
for i = 1:dx
    %disp(i);
    pcaRec =[];
    z = reshape(heart_scale_inst1(i,1:tam1),tamReshape,[]);
    zz1 = mat2cell(z, repmat(numFrequencias,1,tamBlocoX),repmat(4,1,tamBlocoY));
 
    z = reshape(heart_scale_inst1(i,tam1+1: tam1 + tam2),tamReshape,[]);
    zz2 = mat2cell(z, repmat(numFrequencias,1,tamBlocoX),repmat(4,1,tamBlocoY));
 
    z = reshape(heart_scale_inst1(i,tam1+tam2+1:tam1+tam2*2),tamReshape,[]);
    zz3 =  mat2cell(z, repmat(numFrequencias,1,tamBlocoX),repmat(4,1,tamBlocoY));
  
    z = reshape(heart_scale_inst1(i,tam1+tam2*2+1:tam1+tam2*3),tamReshape,[]);
    zz4 =  mat2cell(z, repmat(numFrequencias,1,tamBlocoX),repmat(4,1,tamBlocoY));
    
    [x, y] = size(zz1);
    
    for a = 1:x % Percorre a cï¿½lula 512x512
        for b = 1:y
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


libsvmwrite([name '_final2_' num2str(dy/8) '.txt'], heart_scale_labeltreino, sparse(treinoRed));
disp('Fim')
