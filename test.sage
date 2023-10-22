load('general.sage')

def d22():
    for i in range(6,15,2):
        M = DASEP(i,2,2)
        t = binomial(i,2)
        f = M.first()
        par = [2,1]+[0]*(i-2)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*f))
            
def d23():
    for i in range(4,5):
        M = DASEP(i,2,3)
        t = binomial(i,3)
        f = M.first()
        par = [2,1,1]+[0]*(i-3)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*f))
        par = [2,2,1]+[0]*(i-3)
        for word in CyclicPermutations(par):
            word = ''.join(map(str,word))
            print(word, factor(M.S[word]-u*u*f))
