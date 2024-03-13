R.<u, y> = QQ['u, y']

t = 1

class DASEPL:
    def __init__(self, lattice: int, notype: int, noparticles: int):
        self.n = lattice
        self.p = notype
        self.q = noparticles

    def system(self):
        eqt = []
        vrb = []
        ab = self.q
        while ab < self.p * self.q + 1:
            for par in Partitions(ab, length=self.q, max_part=self.p):
                par = par + [0]*(self.n-self.q)
                for word in Arrangements(par, self.n):
                    w = ''.join(map(str, word))
                    v = var("x_{}".format(w))
                    vrb.append(v)
                    out = 0
                    ind = 0
                    for i in range(self.n-1):
                        if word[i] > word[i+1]:
                            out += t
                            ind += var("x_{}".format(w[0:i]+w[i+1]+w[i]+w[i+2:]))
                        if word[i] < word[i+1]:
                            out += 1
                            ind += t * var("x_{}".format(w[0:i]+w[i+1]+w[i]+w[i+2:]))
                        if word[i] > 0 and word[i] < self.p:
                            out += u
                            ind += y * var("x_{}".format(w[0:i]+str(word[i]+1)+w[i+1:]))
                        if word[i] > 1:
                            out += y
                            ind += u * var("x_{}".format(w[0:i]+str(word[i]-1)+w[i+1:]))

                    eqt.append(out * v == ind)
                    if list(word) == [1]*self.q + [0]*(self.n-self.q):
                        eqt.append(v == 1)
            ab += 1
        return eqt, vrb

    def steady(self):
        eqt, vrb = self.system()
        return solve(eqt,vrb)[0]