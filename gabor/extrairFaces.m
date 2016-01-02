%%
% Extracts the faces of the base FERET based on the positions of eyes
%%
% load the files to the eye positions
caminho = '/media/eucassio/e100b988-494e-4b1d-9e19-a88ff402646d/eucassio/projetos/mestrado/processamento de imagens/colorferet/colorferet/dvd1/data/ground_truths/name_value';
outputPath = '/media/dados/facedatabase/Feret';
fileFolder = fullfile(caminho);
dirOutput = dir(fullfile(fileFolder,'0*'));
fileNames = {dirOutput.name}';
numFrames = numel(fileNames);
cont =0;

for a = 1:numFrames
    name = [fileFolder '/' fileNames{a}];
    imagePath = dir(fullfile(name,'*fc*'));
    facesNum = size(imagePath);
    if(facesNum(1) > 1)
        glasses = imagePath(1).name((size(imagePath(1).name,2) - 5):(size(imagePath(1).name,2) - 5));
        glasses2 = imagePath(2).name((size(imagePath(2).name,2) - 5):(size(imagePath(2).name,2) - 5));
        %if(glasses ~= '_' && glasses2 ~= '_')
            path = [name '/' imagePath(1).name];
            file = textread(path, '%s','delimiter', '\n');
            eye1 = numel(file{17});
            path = [name '/' imagePath(2).name];
            file = textread(path, '%s','delimiter', '\n');
            eye2 = numel(file{17});
            if(eye1 > 21 && eye2 > 21)
                for x = 1:2
                    path = [name '/' imagePath(x).name];
                    
                    file = textread(path, '%s','delimiter', '\n');
                    
                    if(numel(file{17}) > 21)
                        rightEye = [str2double(file{17}(22:24)), str2double(file{17}(26:28))];
                        leftEye = [str2double(file{18}(23:25)), str2double(file{18}(27:29))];
                        mouth = [str2double(file{20}(19:21)), str2double(file{20}(23:25))];
                        
                        tamx = size(imagePath(x).name);
                        baseName = imagePath(x).name(1:tamx(2) - 3);
                        imageName = [baseName 'ppm'];
                        img = imread(['/media/eucassio/e100b988-494e-4b1d-9e19-a88ff402646d/eucassio/projetos/mestrado/processamento de imagens/colorferet/colorferet/dvd1/data/images/' imageName(1:5) '/' imageName]);
                        eyeDistance = rightEye(1) - leftEye(1);
                        increment = 1;
                        
                        if size(img,3) == 3	
                            img = rgb2gray(img);
                        end
                        caras = imcrop(img,[(leftEye(1) - (eyeDistance * increment)/2) (leftEye(2) - (eyeDistance *increment)/2) (eyeDistance * (1 + increment)) (eyeDistance * (1 + increment))]);
                        
                        imwrite(caras, [outputPath '_faces' '/'  baseName 'png'], 'png');
                        cont = cont +1;
                    end
                end
            end
        %end
    end
    
    
end
disp(['End ', int2str(cont) ,' in ', datestr(now, 'HH:MM:SS')]);
disp('Over all');