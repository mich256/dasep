R = QQ[u,t]
M3 = matrix{
    {-2*u,1,1,0},
    {u,-3-u-t,1+2*t,1},
    {u,2+t,-2-u-2*t,1},
    {0,u,u,-2}}
v = gens ker(M3);
p = sum(entries(-v));
p = p#0;
print(sub(p,{u=>1,t=>1}))
