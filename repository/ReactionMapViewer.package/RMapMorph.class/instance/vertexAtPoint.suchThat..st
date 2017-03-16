accessing
vertexAtPoint: aPoint suchThat: guardBlock
	| point |
	point := aPoint - self position.
	^ self
		argminVertex: [ :vertex | (self projector value: vertex) ifNil: [ Float fmax ] ifNotNil: [ :p | p dist: point ] ]
		suchThat: guardBlock