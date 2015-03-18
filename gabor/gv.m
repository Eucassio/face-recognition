function arrayGv = gv(x, img)
[sizeX, sizeY] = size(img);       
arrayGv =1/sizeY * sum(img(x, 1:sizeY));
