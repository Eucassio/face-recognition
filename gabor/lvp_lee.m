function   [lee_h, lee_v] = lvp_lee(img, block_size)

if size(img,3) == 3	% % Check if the input image is grayscale
    img = rgb2gray(img);
end

[m, n] = size(img);

l= floor(m/block_size);
l2= floor(n/block_size);
l = l * l;
l2 = l2 * l2;
sizeX = m/sqrt(l);
sizeY = n/sqrt(l2);
while( (sizeX - floor(sizeX)) > 0)
    block_size = block_size + 1;
    l= floor(m/block_size);
    l = l * l;
    sizeX = m/sqrt(l);
    sizeY = n/sqrt(l);
end
numCol = sqrt(l);
numRow = sqrt(l2);
 
 %disp(sizeX);
 %disp(numCol);
%figure('NumberTitle','Off','Name',['Imagem segmentada, tamanho do bloco: ', int2str(sizeX)]);
%imshow(img,[]);

%for x = 0:sizeY:m
 %   line([0 m], [x x]);
%end

%for y = 0:sizeX:n    
 %   line([y y], [n 0] );
%end

lee_h = zeros([numCol, numRow]);
for t = 1: numRow
    u = zeros([numCol, sizeX]);
    for o = 1:numCol   
        l1 = (o-1) * sizeX + 1;
        l2 = o * sizeX;
        k1 = (t-1) * sizeY + 1;
        k2 = t * sizeY;
        l = 1;
        for i =l1:l2               
            sumTemp = 0;
            for k=k1:k2            
                sumTemp = sumTemp + ((img(i,k) - gv(l, img(l1:l2, k1:k2)))^2); 
            end
            u(o,l) = ((1/(k2-k1))*sumTemp);
            l = l +1;
        end    
    end
    
    for o = 1:numCol
        sumTemp = 0;
        for i = 1:sizeX    
            ei = u(o,i)/sum(u(o,:));
            logEi = 0;
            if(ei == 0)
                logEi=0;
            else
                logEi = log(ei);
            end
            sumTemp = sumTemp + (ei * logEi);
        end
        hrp = -sumTemp;

        lee_h(o,t) = hrp;

    end

end
  
  lee_h = mat2gray(lee_h);
 
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   lee_v = zeros([numCol, numRow]);
for t = 1: numRow
    u = zeros([numRow, sizeY]);
    for o = 1: numCol
        l1 = (o-1) * sizeX + 1;
        l2 = o * sizeX;
        k1 = (t-1) * sizeY + 1;
        k2 = t * sizeY;
        l = 1;
        for j=k1:k2         %variação y
            sumTemp = 0;
            for k =l1:l2    %variação x                
                sumTemp = sumTemp + ((img(k,j) - gh(l, img(l1:l2, k1:k2)))^2); 
            end
            u(o,l) = ((1/(k2-k1))*sumTemp);
            l = l + 1;
        end    
    end
    %disp('---------iniciando----------');
    %disp(u);
    %disp('-------------------');

    for o = 1:numCol   
        sumTemp = 0;
        for j = 1:sizeY  
            ej = u(o,j)/sum(u(o,:));            
            if(ej == 0)
                logEj=0;
            else
                logEj = log(ej);
            end
            sumTemp = sumTemp + (ej * logEj);
        end
        hcp = -sumTemp;

        lee_v(o,t) = hcp;

    end

end
  
  lee_v = mat2gray(lee_v);

