S.<t> = QQ['t']

def weaklyDecreasing(l: list) -> bool:
    for i in range(len(l)-1):
        if l[i] < l[i+1]:
            return False
    return True

class ASEP:
    def __init__(self, p: list):
        self.partition = p

    def system(self):
        eqt = []
        vrb = []
        n = len(self.partition)
        for word in CyclicPermutations(self.partition):
            w1 = ''.join(map(str,word))
            state = State(w1)
            if weaklyDecreasing(word):
                eqt.append(state.vrb == 1)
            else:
                eqt.append(state.balance())
            vrb.append(state.vrb)
            i = 1
            while i < n:
                word.append(word.pop(0))
                w2 = ''.join(map(str,word))
                v = State(w2).vrb
                eqt.append(state.vrb == v)
                vrb.append(v)
                i += 1
        return eqt, vrb
                
    def steady(self):
        eqt, vrb = self.system()
        return solve(eqt, vrb)

    def first(self):
        S = self.steady()[0]
        return S[len(self.partition)].rhs().denominator()

class State():
    def __init__(self, word: str):
        self.vrb = var('x_{}'.format(word))
        self.word = word

    def outdegree(self):
        s = 0
        i = -1
        w = self.word
        w = [eval(i) for i in w]
        while i < len(w)-1:
            if w[i] < w[i+1]:
                s += t
            if w[i] < w[i+1]:
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
            i += 1
        return s

    def balance(self):
        return self.outdegree() == self.indegree()
