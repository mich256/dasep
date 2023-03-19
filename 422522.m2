R = QQ[u,t]
M3 = matrix{
    {-2*u,1,1,0},
    {u,-3-u-t,1+2*t,1},
    {u,2+t,-2-u-2*t,1},
    {0,u,u,-2}}
v = gens ker(M3)
s = 0;
for i from 0 to 3 do (
    s = s + v_(i,0);
    );
print(factor(s))

M = matrix{
    {-(2*u+t+1),2*(1+t),0,0,1,0,1},
    {1+t,-2*(1+t+u),0,0,0,2,0},
    {0,0,-(3+t),2*(1+t),u,0,u},
    {0,0,1+t,-2*(2+t),0,2*u,0},
    {u,0,1,0,-(3+t+u),1+t,t},
    {0,2*u,0,2,1+t,-2*(2+t+u),1+t},
    {u,0,1,0,1,1+t,-(2+2*t+u)}};

v = gens ker(M);
v = mutableMatrix(v);
for i from 0 to 6 do (
    v_(i,0) = v_(i,0) //(-100*(u+2*t+3));
   );
s = 0;
for i from 0 to 6 do (
    s = s + v_(i,0);
    )
print(#terms(s))
    
N = matrix{
    {-1-2*u-t,1+t,0,0,1,0,0,1},
    {1+t,-1-2*u-t,0,0,0,1,1,0},
    {0,0,-3-t,1+t,u,0,0,u},
    {0,0,1+t,-3-t,0,u,u,0},
    {u,0,1,0,-2-u-t,1+t,0,0},
    {0,u,0,1,1+t,-3-u-2*t,1+t,0},
    {0,u,0,1,0,1+t,-3-u-2*t,1+t},
    {u,0,1,0,0,0,1+t,-2-u-t}};

w = gens ker(N);
r = 0;
for i from 0 to 7 do (
    r = r + w_(i,0);
    );
print(#terms(r))
