blocks = [4 8];
c = [0];
subSets = {'12','13','25','26'};
erARfaceIndv = '(?<=-).*?(?=-)';
erARfaceImg = '(?<=\d-).*?(?=\.)';

disp(['Starting in ', datestr(now, 'HH:MM:SS')]);

extrairCaracteristicas('BigFeret_48_56','-', [], blocks, c, '.*?(?=_)','-', 0);
extrairCaracteristicas('Fei_48_56', '-', [], blocks, c, '\d*', '', 0);
extrairCaracteristicas('ARface_48_56', 'iluminacao', {'15','16', '17', '18','19','20'}, blocks, c, erARfaceIndv, erARfaceImg, 0);
extrairCaracteristicas('ARface_48_56', 'oculos', {'8','21'}, blocks, c, erARfaceIndv, erARfaceImg, 0);
extrairCaracteristicas('ARface_48_56', 'oculos_iluminacao', {'9','10','22','23'}, blocks, c, erARfaceIndv, erARfaceImg, 0);
extrairCaracteristicas('ARface_48_56', 'cachecol', {'11','24'}, blocks, c, erARfaceIndv, erARfaceImg, 32);
extrairCaracteristicas('ARface_48_56', 'cachecol_iluminacao', {'12','13','25','26'}, blocks, c, erARfaceIndv, erARfaceImg, 32);
extrairCaracteristicas('ARface_48_56', 'completa', [], blocks, c, erARfaceIndv, '', 0);

disp(['End in ', datestr(now, 'HH:MM:SS')]);