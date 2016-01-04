%%
% Procedure that extracts the vector of characteristics of an image database using the entropy of the Gabor
%%

% image directory
database  = ['BigFeret', 'Fei'];
caminho = ['/media/dados/facedatabase/' database];
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
cont = 1;

% vector with sizes of windows entropy
blocks = [8];
[tamx, tamy] = size(blocks);
numFacesDif = [100];
c = [0 0.05 0.1 0.2];
[tamxNumFacesDif, tamyNumFacesDif] = size(numFacesDif);
t = 1;
for id = 1:size(c,2)
    for a = 1:int64(tamy)
        for r = 1:int64(tamyNumFacesDif)
            numFacesDiff = numFacesDif(r);
            
            disp(['Starting ', int2str(a) ,' in ', datestr(now, 'HH:MM:SS')]);
            block_size = blocks(a);
            name = [fileFolder '/' fileNames{1}];
            img = imread(name);

            %variables to downsample
            d1 = 1;
            d2 = 1;
            disp(c(id));
            
            [n,m] = size(img);
            %n = n/2;
            s = (n*m)/(d1*d2);
            
            if(c(id) == 0)
                gaborArray = gaborFilterBankCurvo(5,8,15,15,c(id));
                [u,v] = size(gaborArray);
                l = u*v*(s/(block_size*block_size));
            else
                gaborArray = gaborFilterBankCurvo(5,16,15,15,c(id));
                [u,v] = size(gaborArray);
                l = u*v*(s/(block_size*block_size));
            end
            
            
            %l = s*u*v*2;
            
            %l = 4500;
            
            people_name = '';
            i = 0;
            init = 10;
            training_label_vector = zeros(init,1);
            training_instance_matrix = zeros(init,l);
            k = 1;
            
            z = 1;
            imgEquals = 1;
            [gaborSizeX, gaborSizeY] = size(gaborArray{1,1});
            
            while(k <= numFrames)
                name = [fileFolder '/' fileNames{k}];
                
                %er = '(?<=-).*?(?=-)';% ER para ARface
                %er = '\d*';% ER para Fei
                er = '.*?(?=_)'; % ER para BigFerret
                people_name_tmp = regexp(fileNames{k}, er, 'match');
                people_name_tmp = people_name_tmp(1);
                %imgIdx = regexp(fileNames{k}, '(?<=\d-).*?(?=\.)', 'match');
                
                imgs = {'12','13','25','26'};
                todasImagens = 1;
                
                if(todasImagens || ismember(imgIdx,imgs))
                    if(strcmp(people_name,people_name_tmp) == 0)
                        people_name = people_name_tmp;
                        i = i + 1;
                        imgEquals = 1;
                    else
                        imgEquals = imgEquals + 1;
                    end
                    if(imgEquals <= numFacesDiff)
                        disp([int2str(i) ' - ' int2str(imgEquals) ' - ' name]);
                        img = imread(name);                        
                        
                        %img = imcrop(img, [0 0 m n]);
                        %figure, imshow(img)%, figure, imshow(I2)
                        %featureVector_h = gaborFeatures2(img, gaborArray,d1,d2,s,l,block_size);
                        %featureVector_h = gaborFeatures(img, gaborArray,d1,d2);
                        %featureVector_h = gaborFeatures2MaxEntropy(img, gaborArray,d1,d2,s,l,block_size);
                        featureVector_h = gaborFeaturesHistGPU2(img, gaborArray,d1,d2,block_size,block_size);
                        
                        training_label_vector(z) = i;
                        training_instance_matrix(z,1:l) = featureVector_h';
                        
                        z = z + 1;
                        numInd = imgEquals;
                    end
                end
                k = k + 1;
                
            end;
            nameOutput = strcat('resultados/filtro_Curvo_histograma_2pi_', database, '_', num2str(c(id)), '_' ,int2str(i), '_', int2str(numInd), '_' , int2str(block_size),'x',int2str(block_size), '_',int2str(u),'x',int2str(v),'_',int2str(gaborSizeX),'x',int2str(gaborSizeY),'.txt');
            disp('Saving ...');
            disp(nameOutput);
            libsvmwrite(nameOutput, training_label_vector, sparse(training_instance_matrix));
            disp(['End ', int2str(a) ,' in ', datestr(now, 'HH:MM:SS')]);
        end
        
        %%-------------------------------------------------------------
        
    end
    disp('Over all');
end