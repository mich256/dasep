R = QQ[u,t]
M = matrix{
    {-2*u,0,0,1,1,0,0,0,0},
    {0,-2-2*u,0,u,u,0,0,1,1},
    {0,0,-2,0,0,0,0,u,u},
    {u,1,0,-3-2*u-t,2*t+1,1,0,0,0},
    {u,1,0,2+t,-2-2*u-2*t,0,1,0,0},
    {0,0,0,u,0,-3-u-t,2*t+1,1,0},
    {0,0,0,0,u,2+t,-2-u-2*t,0,1},
    {0,u,1,0,0,u,0,-4-t-u,2*t+1},
    {0,u,1,0,0,0,u,2+t,-3-u-2*t}};
v = gens ker M;
v = -v//2916;
print(v);
print(factor(v_(3,0)+v_(4,0)));

