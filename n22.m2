R = QQ[u,t]
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
s = 0;
for i from 0 to 6 do (
    s = s + v_(i,0);
    )
print(toString(factor s))
for i from 0 to 6 do (
    v_(i,0) = v_(i,0) //(-100*(u+2*t+3));
    );
print(v)
    
