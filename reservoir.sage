R.<u,t> = QQ['u,t']

class ASEPRSV():
	def __init__(self, size: int):
		self.n = size

	def system(self):
		eqt = []
		vrb = []

		for j in range(2 ** self.n):
			lhs = 0
			rhs = 0
			w = f'{j:0{self.n}b}'
			v = var("x_{}".format(w))
			vrb.append(v)
			for i in range(self.n):
				if w[i] == '0':
					lhs += u
					rhs += var("x_{}".format(w[0:i]+'1'+w[i+1:]))
				if w[i] == '1':
					lhs += 1
					rhs += u * var("x_{}".format(w[0:i]+'0'+w[i+1:]))
				if i != self.n-1:
					if w[i] < w[i+1]:
						lhs += t
						rhs += var("x_{}".format(w[0:i]+w[i+1]+w[i]+w[i+2:]))
					if w[i] < w[i+1]:
						lhs += 1
						rhs += t * var("x_{}".format(w[0:i]+w[i+1]+w[i]+w[i+2:]))
			eqt.append(lhs * v == rhs)
			if j == 0:
				eqt.append(v == 1)
		return eqt, vrb

	def steady(self):
		eqt, vrb = self.system()
		return solve(eqt,vrb)[0]
