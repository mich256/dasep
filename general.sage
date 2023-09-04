R.<u, t> = QQ['u, t']

class DASEP:
    def __init__(self, lattice: int, notype: int, noparticles: int):
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
                    if word == [1]*self.q + [0]*(self.n-self.q):
                        eqt.append(state.vrb == 1)
                    else:
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
        S = S[0]
        x = binomial(self.n,self.q)
        return  R(S[x].rhs().denominator())

class State():
    def __init__(self, dasep: DASEP, word: str):
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

def n23():
    du = open("degU.txt", "a")
    du.write('\n'+'n23')
    pf = open('parFun.txt', 'a')
    pf.write('\n'+'n23')
    cu = open('cofu.txt','a')
    cu.write('\n'+'n23')
    ct = open('constant.txt','a')
    ct.write('\n'+'n23')
    k = 4
    while k < 8:
        item = DASEP(k,2,3).first()
        d = item.degree(u)
        du.write('\n'+str(d))
        pf.write('\n'+str(item(t=1,u=1)))
        cu.write('\n'+str(factor(item.coefficient(u^d))))
        ct.write('\n'+str(item(t=0,u=0)))
        k += 1
    du.close()
    pf.close()
    cu.close()
    ct.close()

def dif(S, index1, index2):
    S = S[0]
    p = S[index1]
    v1 = p.lhs()
    q = S[index2]
    v2 = q.lhs()
    p = p.rhs().numerator()
    q = q.rhs().numerator()
    return v1 - v2 == factor(p-q)
