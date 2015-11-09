function out = l5(G,N,K)
[row,col]=size(G);
% Valores dos blocos
aa = 1:N:row;
bb = 1:K:col;
[ii,jj] = ndgrid(aa,bb);
out = arrayfun(@(x,y) G(x:x+N-1,y:y+K-1),ii,jj,'un',0);