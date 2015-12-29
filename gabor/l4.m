function G = l4(G,u,v,x,y)
g2 = G;
for a = 1:x % Percorre a c�lula 512x512
    for b = 1:y
        % recebe um valor de magnitude
        % Normaliza��o da orienta��o
        gGpu = (G{a,b});
        
        maxi = max(gGpu,[],2);
        
        maxIdx = ~ismember(G{a,b}, maxi);
        g2{a,b}(maxIdx) = 0;
%         for i = 1:u % Percorre os valores de escala e orienta��o 2x3
%             for j = 1:v
%                 % Supress�o n�o m�xima da escala
%                 if G{a,b}(i,j) ~= maxi(i)
%                     G{a,b}(i,j) = 0;
%                 end
%             end
%         end
        
    end
end
%disp(isequal(G,g2))