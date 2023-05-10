u, t = var('u, t')

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
        return S[0][binomial(self.n,self.q)].rhs().denominator()

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
                    s += t*State(self.dasep, w[0:i]+w[i+1]+w[i]+w[i+2:]).vrb
                else:
                    s += t*State(self.dasep, w[-1]+w[1:-1]+w[0]).vrb
            if int(w[i]) > int(w[i+1]):
                if i != -1:
                    s += State(self.dasep, w[0:i]+w[i+1]+w[i]+w[i+2:]).vrb
                else:
                    s += State(self.dasep, w[-1]+w[1:-1]+w[0]).vrb
            if int(w[i]) > 0 and int(w[i]) < self.dasep.p:
                if i != -1:
                    s += State(self.dasep, w[0:i]+str(int(w[i])+1)+w[i+1:]).vrb
                else:
                    s += State(self.dasep, w[0:i]+str(int(w[i])+1)).vrb
            if int(w[i]) > 1:
                if i != -1:
                    s += u*State(self.dasep, w[0:i]+str(int(w[i])-1)+w[i+1:]).vrb
                else:
                    s += u*State(self.dasep, w[0:i]+str(int(w[i])-1)).vrb
            i += 1
        return s

    def balance(self):
        return self.outdegree() == self.indegree()


def n23():
    n = 4
    l = []
    while n < 7:
        M = DASEP(n,2,3)
        l.append(M.first())
        n += 1
    return l

def n32():
    n = 3
    l = []
    while n < 7:
        M = DASEP(n,3,2)
        l.append(M.first())
        n += 1
    return l

def p42():
    p = 2
    l = []
    while p < 7:
        M = DASEP(4,p,2)
        l.append(M.first())
        p += 1
    return l

def infFams1st(func):
    with open("first.txt", "a") as f:
        f.write("\n"+str(func)+"\n")
        f.write("\n".join(str(item) for item in func()))

def degOu(func):
    with open("degree.txt","a") as f:
        f.write('\n'+str(func)+'\n')
        f.write('\n'.join(str(item.degree(u)) for item in func()))
