private
setVertex1: anRMapVertex1 vertex2: anRMapVertex2
	vertex1 := anRMapVertex1.
	vertex2 := anRMapVertex2.
	anRMapVertex1 addEdge: self.
	anRMapVertex2 addEdge: self.