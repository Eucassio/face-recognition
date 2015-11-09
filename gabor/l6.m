function out1 = l6(out,u,v,row,col,K,N)
n = 1;
sum1 = zeros(u,v);
c = 0;
for l = 1:row
    for k = 1:col
        for a = 1:N % Percorre o bloco
            for b = 1:K
                % recebe um valor de magnitude
                
                % Supress�o n�o m�xima da escala
                if n == (N*K)+1
                    n = 1;
                    sum1 = zeros(u,v);
                end
                temp = cell2mat(out{l,k}(a,b));
                sum1 = temp + sum1;
                out1{l,k} = sum1;
                n = n+1;
            end
        end
        c = c+1;
        % Concatena a matriz e realiza o ultimo som�torio
        %soma = sum(out1{l,k},2);
        %soma2 = sum(soma);
        %out2(l,k) = soma2;
        
        
    end
end