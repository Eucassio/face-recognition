function G2 = l3(G,u,v,x,y)
if(u >1)
    G2 = cell(y,x);
    for a = 1:y % Percorre a cï¿½lula 512x512
        for b = 1:x
            % recebe um valor de magnitude
            % Normalizaï¿½ï¿½o da orientaï¿½ï¿½o
             norms = sqrt(sum(G{a,b}.^2,1));
             %norms = round(norms,6);
             %norm2 = zeros(u,v);
            % norm2 = zeros(u,v);
             norm2 = repmat(norms,u,1);
             
             maxIdx = ismember(norm2, 0);
             norm2(maxIdx) = abs(realmin());
             
             ttt = G{a,b}./norm2;    
             G2{a,b}=ttt;
%             for i = 1:u % Percorre os valores de escala e orientaï¿½ï¿½o 2x3
%                 for j = 1:v
%                     % Normalizaï¿½ï¿½o da orientaï¿½ï¿½o
%                     %norma = norm(G{a,b}(:,j));
%                     G5{a,b}(i,j) = G{a,b}(i,j)/round(norm(G{a,b}(:,j)),6);
%                 end
%             end
        end
    end
   
end
%disp(isequal(G5,G2));