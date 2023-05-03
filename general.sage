from sage.combinat.permutation import Permutations_mset

t,u = var('t,u')

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
                for word in Permutations_mset(par):
                    word = ''.join(map(str,word))
                    state = State(self,word)
                    eqt.append(state.balance())
                    vrb.append(state.vrb)
            ab += 1
        return eqt,vrb

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
                s += State(self.dasep, w[0:i]+str(int(w[i])+1)+w[i+1:]).vrb
            if int(w[i]) > 1:
                s += u*State(self.dasep, w[0:i]+str(int(w[i])-1)+w[i+1:]).vrb
            i += 1
        return s

    def balance(self):
        return [self.outdegree() == self.indegree()]
    
