accessing
value: anRMapVertex
	^ (super value: anRMapVertex)
		ifNotNil: [ :p0 | 
			| dx dy |
			(self z: anRMapVertex)
				ifNotNil: [ :z | 
					dx := theta cos * rmap width * self r / (z + 0.1) / rmap viewScale.
					dy := theta sin * rmap width * self r / (z + 0.1) / rmap viewScale.
					(p0 x + dx) @ (p0 y + dy) ] ]