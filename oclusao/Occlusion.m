function [ I ] = Occlusion( I )
%I = rgb2gray(I);
B = imread('baboon2.jpg');
B = rgb2gray(B);
J2 = imresize(B, 0.2, 'nearest');
[M, N] = size(I);
Tam = M * N;

C = randi([10 50],[1 1]);% Gera um n�mero ale�torio entre 10 e 50
%OK% Redimensiona a imagem com a porcentagem gerada

Tam = Tam * C; %Pega o tamanho da imagem original e multiplica pela porcentagem
Tam = sqrt(Tam); %Tira a raiz do tamanho 
Tam = round(Tam)/10; %Transforma para n�mero inteiro
J3 = imresize(J2, [Tam Tam]); %Aplica o redimensionamento da imagem 

[u, v] = size(J3);% Armazena o tamanho da imagem final em v�riaveis u e v
andar = N - v;% Subtrai o n�mero de linhas da imagem original pelo n�mero de linhas da imagem do macaco

% XB recebe um valor randomico entre 1 e "andar" e manda para a variav�l rand
% que a seguir manda as coordenadas ale�torias para a fun��o de
% sobreposi��o.
XB = randi([1 andar],[1 1]); 
rand = XB;
 
% XA recebe um valor randomico o n�mero de colunas u e M e manda para a variav�l
% rand1 que a seguir manda as coordenadas ale�torias para a fun��o de
% sobreposi��o.
XA = randi([u M],[1 1]);
rand1 = XA;

% Vari�veis de movimento
x1 = rand1 - u + 1;
y2 = rand + v - 1;
% X1 = NUM ALEATORIO - ALTURA DA IMAGEM DO MACACO + 1;
% Y2 = NUM ALEATORIO + COMPRIMENTO DA IMAGEM DO MACACO - 1

I(x1:rand1,rand:y2) = J3(:,:);

end




