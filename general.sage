R.<u, t, y> = QQ['u, t, y']

class DASEP:
    def __init__(self, lattice: int, notype: int, noparticles: int):
        self.n = lattice
        self.p = notype
        self.q = noparticles
        self.f = 0

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
        return solve(eqt,vrb)[0]

    def first(self):
        foo = self.steady()
        self.f = R(foo[binomial(self.n,self.q)].rhs().denominator())
        for i in foo:
            v = str(i.lhs())[2:]
            self.f = lcm(self.f, R(i.rhs().denominator()))
            st = R(i.rhs().numerator())*(self.f//R(i.rhs().denominator()))
            self.S[v] = st
        return self.f

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
                s += y
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
                    s += y*var("x_{}".format(w[0:i]+str(int(w[i])+1)+w[i+1:]))
                else:
                    s += y*var("x_{}".format(w[0:i]+str(int(w[i])+1)))
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
    deform = open('deform.txt','a')
    deform.write('\n'+'n22')
    k = 3
    while k < 8:
       item = DASEP(k,2,2).first()
       item = item//y^2
       deform.write('\n'+str(factor(item(u=0,y=0))))
       k+=1
    deform.close()
    
def n23():
    #du = open("degU.txt", "a")
    #du.write('\n'+'n23')
    #cu = open('cofu.txt','a')
    #cu.write('\n'+'n23')
    #ct = open('constant.txt','a')
    #ct.write('\n'+'n23')
    deform = open('deform.txt','a')
    deform.write('\n'+'n23')
    k = 4
    while k < 7:
       item = DASEP(k,2,3).first()
       item = item//y^3
       #d = item.degree(u)
       deform.write('\n'+str(factor(item(u=0,y=0))))
       #du.write('\n'+str(d))
       #cu.write('\n'+str(factor(item.coefficient(u^d))))
       #ct.write('\n'+str(item(u=0,y=0)))
       k += 1
    #du.close()
    #cu.close()
    #ct.close()
    deform.close()

def n2n1():
    #du = open("degU.txt","a")
    #du.write('\n'+'n2n1')
    #cu = open('cofu.txt','a')
    #cu.write('\n'+'n2n1')
    #ct = open('constant.txt','a')
    #ct.write('\n'+'n2n1')
    deform = open('deform.txt','a')
    deform.write('\n'+'n2n1')
    k = 3
    while k < 7:
       item = DASEP(k,2,k-1).first()
       #d = item.degree(u)
       item = item//y^(k-1)
       deform.write('\n'+str(factor(item(u=0,y=0))))
       #du.write('\n'+str(d))
       #cu.write('\n'+str(factor(item.coefficient(u^d))))
       #ct.write('\n'+str(item(u=0,y=0)))
       k += 1
    #du.close()
    #cu.close()
    #ct.close()
    deform.close()

def p32():
    #du = open("degU.txt","a")
    #du.write('\n'+'3p2')
    #cu = open('cofu.txt','a')
    #cu.write('\n'+'3p2')
    #ct = open('constant.txt','a')
    #ct.write('\n'+'3p2')
    deform = open('deform.txt','a')
    deform.write('\n'+'3p2')
    k = 3
    while k < 7:
       item = DASEP(3,k,2).first()
       #d = item.degree(u)
       item = item//y^2
       deform.write('\n'+str(factor(item(u=0,y=0))))
       #du.write('\n'+str(d))
       #cu.write('\n'+str(factor(item.coefficient(u^d))))
       #ct.write('\n'+str(item(u=0,y=0)))
       k += 1
    #du.close()
    #cu.close()
    #ct.close()
    deform.close()

def n24():
    du = open("degU.txt","a")
    du.write('\n'+'n24')
    cu = open('cofu.txt','a')
    cu.write('\n'+'n24')
    ct = open('constant.txt','a')
    ct.write('\n'+'n24')
    k = 5
    while k < 7:
        item = DASEP(k,2,4).first()
        d = item.degree(u)
        du.write('\n'+str(d))
        cu.write('\n'+str(factor(item.coefficient(u^d))))
        ct.write('\n'+str(item(u=0,y=0)))
        k += 1
    du.close()
    cu.close()
    ct.close()
