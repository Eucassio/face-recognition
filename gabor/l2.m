function [G, G2] = l2(gArray,u,v,x,y)
        
h = 0;
f = 1;
idx = zeros(1,u*v);
G = cell(x,y);
G2 = cell(x,y);
for a = 1:x
    for b = 1:y
        t = 1;
        z = -y;
        q = 1;
        
        while(z + y + h + b <= x*v*y*u)
           
            idx(t) = z + y + h + b;

            if(mod(t,u) == 0)
                z = q * (y*u*x) -y;
                q = q+1;
            else
                z = z+y;
            end
            t = t + 1;
        end
        zz = gArray(idx);     
        zz = reshape(zz,u,v);
        %G{b,a} = gpuArray(zz); 
        G2{a,b} = zz;
        idx = [];
    end
    h = (y*u)*f;
    f = f+ 1;
end