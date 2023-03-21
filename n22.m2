R = QQ[u,t]
markovMatrix= n->
(if n%2==1 then (
k=(n-1)//2;
m=mutableMatrix(R,4*k,4*k);
m_(0,0)=-1-2*u-t;
m_(1,0)=1+t;
m_(2*k,0)=u;
m_(4*k-1,0)=u;
for i from 1 to k-2 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(4*k-1-i,i)=u;
    m_(2*k+i,i)=u;
    m_(i,i)=-2*(1+u+t);
    );
m_(k-2,k-1)=1+t;
m_(3*k-1,k-1)=u;
m_(3*k,k-1)=u;
m_(k-1,k-1)=-1-2*u-t;

m_(k,k)=-3-t;
m_(k+1,k)=1+t;
m_(2*k,k)=1;
m_(4*k-1,k)=1;

for i from k+1 to 2*k-2 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(5*k-1-i,i)=1;
    m_(k+i,i)=1;
    m_(i,i)=-4-2*t;
    );
m_(2*k-2,2*k-1)=1+t;
m_(3*k-1,2*k-1)=1;
m_(3*k,2*k-1)=1;
m_(2*k-1,2*k-1)=-3-t;

m_(2*k+1,2*k)=1+t;
m_(4*k-1,2*k)=1;
m_(0,2*k)=1;
m_(k,2*k)=u;
m_(2*k,2*k)=-3-u-t;

for i from 2*k+1 to 3*k-1 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(i-2*k,i)=1;
    m_(i-k,i)=u;
    m_(i,i)=-3-u-2*t;
    );
for i from 3*k to 4*k-2 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(4*k-1-i,i)=1;
    m_(5*k-1-i,i)=u;
    m_(i,i)=-3-u-2*t;
    );
m_(4*k-2,4*k-1)=1+t;
m_(2*k,4*k-1)=t;
m_(0,4*k-1)=1;
m_(k,4*k-1)=u;
m_(4*k-1,4*k-1)=-2-u-2*t;
)
else if n%2==0 then (
k=n//2;
m=mutableMatrix(R,4*k-1,4*k-1);
m_(0,0)=-1-2*u-t;
m_(1,0)=1+t;
m_(2*k,0)=u;
m_(4*k-2,0)=u;

for i from 1 to k-2 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(4*k-2-i,i)=u;
    m_(2*k+i,i)=u;
    m_(i,i)=-2*(1+u+t);
    );

m_(k-2,k-1)=2*(1+t);
m_(3*k-1,k-1)=2*u;
m_(k-1,k-1)=-2-2*u-2*t;

m_(k,k)=-3-t;
m_(k+1,k)=1+t;
m_(2*k,k)=1;
m_(4*k-2,k)=1;

for i from k+1 to 2*k-2 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(5*k-2-i,i)=1;
    m_(k+i,i)=1;
    m_(i,i)=-4-2*t;
    );

m_(2*k-2,2*k-1)=2*(1+t);
m_(3*k-1,2*k-1)=2;
m_(2*k-1,2*k-1)=-4-2*t;

m_(2*k+1,2*k)=1+t;
m_(4*k-2,2*k)=1;
m_(0,2*k)=1;
m_(k,2*k)=u;
m_(2*k,2*k)=-3-u-t;

for i from 2*k+1 to 3*k-2 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(i-2*k,i)=1;
    m_(i-k,i)=u;
    m_(i,i)=-3-u-2*t;
    );
m_(3*k-2,3*k-1)=1+t;
m_(3*k,3*k-1)=1+t;
m_(k-1,3*k-1)=2;
m_(2*k-1,3*k-1)=2*u;
m_(3*k-1,3*k-1)=-4-2*u-2*t;
for i from 3*k to 4*k-3 do (
    m_(i-1,i)=1+t;
    m_(i+1,i)=1+t;
    m_(4*k-2-i,i)=1;
    m_(5*k-2-i,i)=u;
    m_(i,i)=-3-u-2*t;
    );
m_(4*k-3,4*k-2)=1+t;
m_(2*k,4*k-2)=t;
m_(0,4*k-2)=1;
m_(k,4*k-2)=u;
m_(4*k-2,4*k-2)=-2-u-2*t;
);
matrix(m)
);

for i from 4 to 4 do (
M = markovMatrix(2*i);
v = gens ker(M);
);
