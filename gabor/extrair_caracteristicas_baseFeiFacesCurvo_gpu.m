%%
% Procedure that extracts the vector of characteristics of an image database using the entropy of the Gabor
%%

% image directory
%parpool('local',16);
database  = 'test2_crop';
caminho = ['E:\facedatabase\' database];
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.jpg'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
cont = 1;

% vector with sizes of windows entropy
blocks = [8];
[tamx, tamy] = size(blocks);
numFacesDif = [14];
[tamxNumFacesDif, tamyNumFacesDif] = size(numFacesDif);
t = 1;
for a = 1:int64(tamy)
    for r = 1:int64(tamyNumFacesDif)
        numFacesDiff = numFacesDif(r);
        
    disp(['Starting ', int2str(a) ,' in ', datestr(now, 'HH:MM:SS')]);
    block_size = blocks(a);
    name = [fileFolder '\' fileNames{1}];
    img = imread(name);
    [img_h, img_v] = lvp_lee(img, block_size);
    
    %variables to downsample    
    d1 = 1;
    d2 = 1;
    
    gaborArray = gaborFilterBankCurvo(5,16,30,30,0.1);
    [u,v] = size(gaborArray);
    [n,m] = size(img_h);
    s = (n*m)/(d1*d2);
    l = s*u*v;
    
    people_name = '';
    %i = 0;
    m = 10;
    training_label_vector = zeros(m,1);
    training_instance_matrix = zeros(m,l);
    k = 1;

    z = 1;
    imgEquals = 1;

    [gaborSizeX, gaborSizeY] = size(gaborArray{1,1});
    
    %while(k <= numFrames)
    %parfor
    parfor k = 1:30    
        name = [fileFolder '/' fileNames{k}];

            [~, imgIdx] = strtok(fileNames{k},'-');
            [people_name_tmp, imgIdx] = strtok(imgIdx,'-');
            %if(strcmp(imgIdx,'-11.jpg') == 1 || strcmp(imgIdx,'-13.jpg') == 1 || strcmp(imgIdx,'-11 1.jpg') == 1)
                %if(strcmp(people_name,people_name_tmp) == 0)
                %    people_name = people_name_tmp;
                    %i = i + 1;
                    %imgEquals = 1;
                %else
                    %imgEquals = imgEquals + 1;
               % end
                %if(imgEquals <= numFacesDiff)
                    %disp([int2str(i) ' - ' int2str(imgEquals) ' - ' name]);
                    disp([' - ' int2str(imgEquals) ' - ' name]);
                    img = imread(name);

                    %featureVector_h = gaborFeatures2(img, gaborArray,d1,d2,s,l,block_size);
                    %featureVector_h = gaborFeatures(img, gaborArray,d1,d2);
                    %featureVector_h = gaborFeatures2MaxEntropy(img, gaborArray,d1,d2,s,l,block_size);
                    featureVector_h = gaborFeaturesHistGPU2(img, gaborArray,d1,d2,block_size,block_size);

                    %training_label_vector(z) = i;
                    %training_instance_matrix(z,1:l) = featureVector_h';

                    z = z + 1;
                    %numInd = imgEquals;
                %end
            %end
           % k = k + 1;            
    end;
    nameOutput = strcat('hist_gabor_curvo_', database, '_',int2str(i), '_', int2str(numInd), '_' , int2str(block_size),'x',int2str(block_size), '_',int2str(u),'x',int2str(v),'_',int2str(gaborSizeX),'x',int2str(gaborSizeY),'.txt');
    disp('Saving ...');
    disp(nameOutput);
    libsvmwrite(nameOutput, training_label_vector, sparse(training_instance_matrix));
    disp(['End ', int2str(a) ,' in ', datestr(now, 'HH:MM:SS')]);
    end
    
    %%-------------------------------------------------------------
    
end
disp('Over all');