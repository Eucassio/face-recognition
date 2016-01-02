%%
% Procedure that extracts the vector of characteristics of an image database using the entropy of the Gabor
%%

% image directory
caminho = '/home/eucassio/projetos/mestrado/Faces/occlusion';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'*.jpg'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
cont =1;

% vector with sizes of windows entropy
blocks = [3, 5];
[tamx, tamy] = size(blocks);
for a = 1:int64(tamy)
    
    disp(['Starting ', int2str(a) ,' in ', datestr(now, 'HH:MM:SS')]);
    block_size = blocks(a);
    name = [fileFolder '/' fileNames{1}];
    img = imread(name);
    [img_h, img_v] = lvp_lee(img, block_size);
    
    %variables to downsample    
    d1 = 1;
    d2 = 1;
    
    gaborArray = gaborFilterBank(1,4,9,9);
    [u,v] = size(gaborArray);
    [n,m] = size(img_h);
    s = (n*m)/(d1*d2);
    l = s*u*v*2;
    
    people_name = '';
    i = 0;
    m = 10;
    training_label_vector = zeros(m,1);
    training_instance_matrix = zeros(m,l);
    k = 1;

    z = 1;
    imgEquals = 1;
    while(k <= numFrames)
        name = [fileFolder '/' fileNames{k}];

            [people_name_tmp, imgIdx] = strtok(fileNames{k},'.');

            if(strcmp(people_name,people_name_tmp) == 0)
                people_name = people_name_tmp;
                i = i + 1;
                imgEquals = 1;
            else
                imgEquals = imgEquals + 1;
            end
            if(imgEquals < 100)
                disp([int2str(i) ' - ' name]);
                img = imread(name);
                
                featureVector_h = gaborFeatures2(img, gaborArray,d1,d2,s,l,block_size);
                %featureVector_h = gaborFeatures(img, gaborArray,d1,d2);
                
                      
                training_label_vector(z) = i;
                training_instance_matrix(z,1:l) = featureVector_h';
           
                z = z + 1;
             
            end
            
            k = k + 1;
    end;
    nameOutput = strcat('features_', int2str(block_size),'x',int2str(block_size),'.txt');
    disp('Saving ...');
    disp(nameOutput);
    libsvmwrite(nameOutput, training_label_vector, sparse(training_instance_matrix));
    disp(['End ', int2str(a) ,' in ', datestr(now, 'HH:MM:SS')]);
    
    
    %%-------------------------------------------------------------
    
end
disp('Over all');