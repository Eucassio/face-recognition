function [ A ] = gaborMaxCurvo(img)

gaborArray = gaborFilterBankCurvo(5,8,30,30,0);
gaborArray1 = gaborFilterBankCurvo(5,16,30,30,0.05);
gaborArray2 = gaborFilterBankCurvo(5,16,30,30,0.1);
gaborArray3 = gaborFilterBankCurvo(5,16,30,30,0.2);


imgMax = gaborFeaturesMaximo(img,gaborArray);
imgMax1 = gaborFeaturesMaximo(img,gaborArray1);
imgMax2 = gaborFeaturesMaximo(img,gaborArray2);
imgMax3 = gaborFeaturesMaximo(img,gaborArray3);

A{1,1} = imgMax;
A{1,2} = imgMax1;
A{2,1} = imgMax2;
A{2,2} = imgMax3;
    
end

