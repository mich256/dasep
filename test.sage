load('general.sage')

def d22():
    for i in range(3,10):
        M = DASEP(i,2,2)
        t = binomial(i,2)
        S = M.steady()[0]
        for j in range(t,t*3,i):
            foo = S[j]
            print(foo.lhs())
            foo = foo.rhs()
            p = foo.numerator()
            q = foo.denominator()
            print(factor(p-u*q))

def d23():
    for i in range(4,5):
        M = DASEP(i,2,3)
        t = binomial(i,3)
        S = M.steady()[0]
        for j in range(t,t*4,i):
            foo = S[j]
            print(foo.lhs())
            foo = foo.rhs()
            p = foo.numerator()
            q = foo.denominator()
            print(factor(p-u*q))
        for j in range(t*4,t*7,i):
            foo = S[j]
            print(foo.lhs())
            foo = foo.rhs()
            p = foo.numerator()
            q = foo.denominator()
            print(factor(p-u*u*q))
        
