accessing
edgePointsFor: anRMapVertex do: aBlock
	| halfWidth halfHeight |
	(self formFor: anRMapVertex)
		in: [ :form | 
			halfWidth := form width / 2.0.
			halfHeight := form height / 2.0 ].
	(rmap projector value: anRMapVertex)
		ifNotNil: [ :position | 
			aBlock value: (position x - halfWidth) @ (position y - halfHeight).
			aBlock value: (position x + halfWidth) @ (position y - halfHeight).
			aBlock value: (position x - halfWidth) @ (position y + halfHeight).
			aBlock value: (position x + halfWidth) @ (position y + halfHeight) ]