load('general.sage')

def d22():
    for i in range(6,15,2):
        M = DASEP(i,2,2)
        f = M.first()
        par = [2,1]+[0]*(i-2)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*f))
            
def d23():
    for i in range(4,5):
        M = DASEP(i,2,3)
        f = M.first()
        par = [2,1,1]+[0]*(i-3)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*f))
        par = [2,2,1]+[0]*(i-3)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*u*f))

def d24():
    for i in range(5,6):
        M = DASEP(i,2,4)
        f = M.first()
        par = [2,1,1,1]+[0]*(i-4)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*f))
        par = [2,2,1,1]+[0]*(i-4)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*u*f))
        par = [2,2,2,1]+[0]*(i-4)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*u*u*f))

def d32():
    for i in range(3,6):
        M = DASEP(i,3,2)
        f = M.first()
        par = [2,1]+[0]*(i-2)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            temp = M.S[word]-u*f
            print(word, (lambda: factor(temp) if temp != 0 else None)())
        par = [3,1]+[0]*(i-2)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            temp = M.S[word]-u**2*f
            print(word, (lambda: factor(temp) if temp != 0 else None)())
        par = [3,2]+[0]*(i-2)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            temp = M.S[word]-u**3*f
            print(word, (lambda: factor(temp) if temp != 0 else None)())

def eulerian():
    for i in range(3,7):
        M = DASEP(i,2,i-1)
        f = M.first()
        par = [0,2]+[1]*(i-2)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*f))
