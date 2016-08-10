fileRead = strcat('filtro_gabor_entropia_2pi_ARface_48_56_iluminacao_0_100_6_4x4_1x4_15x15_.txt');%Treino
% disp(fileRead);
[heart_scale_label, heart_scale_inst] = libsvmread(fileRead);
heart_scale_instreino = full(heart_scale_inst);
%% Divide em 10 grupos de teste e treino
[num_ind, num_val] = size(heart_scale_instreino);
num_k = num_ind/10;
k = 0;
for i = 1:10
groups{1,i} = heart_scale_inst(1+k:k+60,:);
labels{1,i} = heart_scale_label(1+k:k+60,:);
k = k + 60;
end
%% Gera os dados de treino e teste
numero_K = 10;
Matriz_final = [];
for indice = 1: numero_K
new_label = [];
new_group = [];

for i = 1: 10
if(i ~= indice)
    label = labels{1,i}';
    group = groups{1,i}';
    new_label = [new_label label];
    new_group = [new_group group];
else 
end
end
treino_label = new_label';
treino_group = new_group';
teste_label = labels{1,indice};
teste_group = groups{1,indice};
%% Realização dos testes e dos treinos
estimacao = svmtrain(treino_label, treino_group);
[predict_label, accuracy, dec_values] = svmpredict(teste_label, teste_group, estimacao);
C = confusionmat(teste_label,predict_label);
MatrizConfusion{1,indice} = C; 
end

