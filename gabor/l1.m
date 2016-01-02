function gaborResult = l1(img, gaborArray,u,v,x,y)
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        
        gaborResult{i,j} = (abs(conv2((img),(gaborArray{i,j}),'same')));

        % chave � cell e parenteses � a matriz naquela posi��o da c�lula
        % Faz a troca
        
%         for a = 1:y
%             for b = 1:x
%                 G{a,b}(i,j) = gaborResult{i,j}(a,b);
%             end
%         end
    end
end
