R.<u, t> = QQ['u, t']

class DASEP:
    def __init__(self,lattice,notype,noparticles):
        self.n = lattice
        self.p = notype
        self.q = noparticles

    def system(self):
        eqt = []
        vrb = []
        ab = self.q
        while ab < self.p*self.q+1:
            for par in Partitions(ab,length=self.q,max_part=self.p):
                par = par+[0]*(self.n-self.q)
                for word in CyclicPermutations(par):
                    w1 = ''.join(map(str,word))
                    state = State(self,w1)
                    eqt.append(state.balance())
                    vrb.append(state.vrb)
                    i = 1
                    while i < self.n:
                        word.append(word.pop(0))
                        w2 = ''.join(map(str,word))
                        v = State(self,w2).vrb
                        eqt.append(state.vrb == v)
                        vrb.append(v)
                        i += 1
            ab += 1
        return eqt,vrb

    def steady(self):
        eqt, vrb = self.system()
        return solve(eqt,vrb)

    def first(self):
        S = self.steady()
        I = ideal(R(S[0][binomial(self.n,self.q)].rhs().denominator()))
        J = ideal(R(u))
        return I.saturation(J)[0].gens()[0]

class State():
    def __init__(self,dasep,word):
        self.vrb = var("x_{}".format(word))
        self.dasep = dasep
        self.word = word

    def outdegree(self):
        s = 0
        i = -1
        w = self.word
        w = [eval(i) for i in w]
        while i < len(w)-1:
            if w[i] > w[i+1]:
                s += t
            if w[i] < w[i+1]:
                s += 1
            if w[i] > 0 and w[i] < self.dasep.p:
                s += u
            if w[i] > 1:
                s += 1
            i += 1
        return s*self.vrb

    def indegree(self):
        s = 0
        i = -1
        w = self.word
        while i < len(w)-1:
            if int(w[i]) < int(w[i+1]):
                if i != -1:
                    s += t*var("x_{}".format(w[0:i]+w[i+1]+w[i]+w[i+2:]))
                else:
                    s += t*var("x_{}".format(w[-1]+w[1:-1]+w[0]))
            if int(w[i]) > int(w[i+1]):
                if i != -1:
                    s += var("x_{}".format(w[0:i]+w[i+1]+w[i]+w[i+2:]))
                else:
                    s += var("x_{}".format(w[-1]+w[1:-1]+w[0]))
            if int(w[i]) > 0 and int(w[i]) < self.dasep.p:
                if i != -1:
                    s += var("x_{}".format(w[0:i]+str(int(w[i])+1)+w[i+1:]))
                else:
                    s += var("x_{}".format(w[0:i]+str(int(w[i])+1)))
            if int(w[i]) > 1:
                if i != -1:
                    s += u*var("x_{}".format(w[0:i]+str(int(w[i])-1)+w[i+1:]))
                else:
                    s += u*var("x_{}".format(w[0:i]+str(int(w[i])-1)))
            i += 1
        return s

    def balance(self):
        return self.outdegree() == self.indegree()

def n22():
    n = 3
    l = []
    while n < 7:
        M = DASEP(n,2,2)
        l.append(M.first())
        n += 1
    return l


def n23():
    n = 4
    l = []
    while n < 7:
        M = DASEP(n,2,3)
        l.append(M.first())
        n += 1
    return l

def n24():
    n = 5
    l = []
    while n < 7:
        M = DASEP(n,2,4)
        l.append(M.first())
        n += 1
    return l

def p42():
    p = 2
    l = []
    while p < 6:
        M = DASEP(4,p,2)
        l.append(M.first())
        p += 1
    return l

def n2n1():
    n = 3
    l = []
    while n < 6:
        M = DASEP(n,2,n-1)
        l.append(M.first())
        n += 1
    return l

def n2n2():
    n = 4
    l = []
    while n < 6:
        M = DASEP(n,2,n-2)
        l.append(M.first())
        n += 1
    return l

def infFams1st(func):
    f1 = open("first.txt", "a")
    f1.write("\n"+str(func))
    du = open("degU.txt", "a")
    du.write('\n'+str(func))
    for item in func():
        f1.write('\n'+str(item))
        du.write('\n'+str(item.degree(u)))
    f1.close()
    du.close()
