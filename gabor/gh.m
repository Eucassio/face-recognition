function arrayGh = gh(y, img)
[sizeX, sizeY] = size(img);       
arrayGh =1/sizeX * sum(img(1:sizeX, y));
