function [G, G2] = l2(gArray,u,v,x,y)
h = 0;
f = 1;
idx = zeros(1,u*v);
G = cell(x,y);
G2 = cell(x,y);
for a = 1:y
    for b = 1:x
        t = 1;
        z = -x;
        q = 1;
        while(z + x + (h +( b)) <= x*v*y*u)
            idx(t) = z + x + h + b;

            if(mod(t,u) == 0)
                z = q * (x*u*x) -x;
                q = q+1;
            else
                z = z+x;
            end
            t = t + 1;
        end
        zz = gArray(idx);     
        zz = reshape(zz,u,v);
        %G{b,a} = gpuArray(zz); 
        G2{b,a} = zz;
        idx = [];
    end
    h = (x*u)*f;
    f = f+ 1;
end