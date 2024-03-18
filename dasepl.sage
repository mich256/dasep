R.<u,t> = QQ['u,t']

# symmetric version, stationary measure is product geometric

class DASEPL:
    def __init__(self, lattice: int, notype: int):
        self.n = lattice
        self.p = notype
        #TODO vars (u_1, u_2,..., u_n)
        #self.variables = vars()

    def system(self):
        eqt = []
        vrb = []
        #TODO update the way it iterates
        ab = 0
        while ab < self.p * self.n:
            for par in Partitions(ab, max_part=self.p):
                par = par + [0] * (self.n-len(par))
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
                        if word[i] < self.p:
                            out += u
                            ind += var("x_{}".format(w[0:i]+str(word[i]+1)+w[i+1:]))
                        if word[i] > 1:
                            out += 1
                            ind += u * var("x_{}".format(w[0:i]+str(word[i]-1)+w[i+1:]))

                    eqt.append(out * v == ind)
                    if ab == 0:
                        eqt.append(v == 1)
            ab += 1
        return eqt, vrb

    def steady(self):
        eqt, vrb = self.system()
        return solve(eqt,vrb)[0]