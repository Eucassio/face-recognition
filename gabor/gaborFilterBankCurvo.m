function gaborArray = gaborFilterBankCurvo(u,v,m,n,c)
%
% GABORFILTERBANK generates a custum Gabor filter bank. 
% It creates a u by v array, whose elements are m by n matries; 
% each matrix being a 2-D Gabor filter.
% 
% 
% Inputs:
%       u	:	No. of scales (usually set to 5) 
%       v	:	No. of orientations (usually set to 8)
%       m	:	No. of rows in a 2-D Gabor filter (an odd integer number usually set to 39)
%       n	:	No. of columns in a 2-D Gabor filter (an odd integer number usually set to 39)
% 
% Output:
%       gaborArray: A u by v array, element of which are m by n 
%                   matries; each matrix being a 2-D Gabor filter   
% 
% 
% Sample use:
% 
% gaborArray = gaborFilterBank(5,8,39,39);
% 
% 
%   Details can be found in:
%   
%   M. Haghighat, S. Zonouz, M. Abdel-Mottaleb, "Identification Using 
%   Encrypted Biometrics," Computer Analysis of Images and Patterns, 
%   Springer Berlin Heidelberg, pp. 440-448, 2013.
% 
% 
% (C)	Mohammad Haghighat, University of Miami
%       haghighat@ieee.org
%       I WILL APPRECIATE IF YOU CITE OUR PAPER IN YOUR WORK.



%if (nargin ~= 4)    % Check correct number of arguments
 %   error('There should be four inputs.')
%end


%% Create Gabor filters

% Create u*v gabor filters each being an m*n matrix

gaborArray = cell(u,v);
fmax = 1;
gama = sqrt(2);
eta = sqrt(2);

for i = 1:u
    
    fu = fmax/((sqrt(2))^(i-1));
    alpha = fu/gama;
    beta = fu/eta;
    gama = 2*pi;
    for j = 1:v
        tetav = ((j-1)/v)*pi;
        gFilter = zeros(m,n);
        
        kv = 2^(-(fu + 2)/2)*pi;
        fi = tetav*(pi/8);
        
        for x = 1:m
            for y = 1:n
                x1 = (x-((m+1)/2));
                y1 = (y-((n+1)/2));
                %xprime = x1*cos(tetav)+y1*sin(tetav);
                %yprime = -x1*sin(tetav)+y1*cos(tetav);
                %gFilter(x,y) = (fu^2/(pi*gama*eta))*exp(-((alpha^2)*(xprime^2)+(beta^2)*(yprime^2)))*exp(1i*2*pi*fu*xprime);
                
                
                p1 = -(kv^2)/(2*gama^2) * (( x1*cos(fi) + y1*sin(fi) + c*(-x1*sin(fi)+y*cos(fi))^2)^2 + (-x1*sin(fi)+y*cos(fi))^2);
                
                p2 = 1i*kv*( x1*cos(fi) + y*sin(fi) + c*(-x*sin(fi)+ y*cos(fi))^2 ) - exp(-(gama^2)/2);
                
                gFilter(x,y) = (kv^2)/(gama^2) * exp(p1) * exp(p2);
                
            end
        end
        gaborArray{i,j} = gFilter;
        
    end
end


%% Show Gabor filters

%Show magnitudes of Gabor filters:
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters Bank');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j);        
% 
%         imshow(abs(gaborArray{i,j}),[]);
%      
%     end
% end
% % 
% % Show real parts of Gabor filters:
figure('NumberTitle','Off','Name','Real parts of Gabor filters Bank');
for i = 1:u
    fu = fmax/((sqrt(2))^(i-1));
    kv = 2^(-(fu + 2)/2)*pi;
    for j = 1:v        
        subplot(u,v,(i-1)*v+j);   
        tetav = ((j-1)/v)*pi;
        imshow(real(gaborArray{i,j}),[]);
        title([ num2str(radtodeg(tetav)) ' - ' num2str(kv) ]);
    end
end
