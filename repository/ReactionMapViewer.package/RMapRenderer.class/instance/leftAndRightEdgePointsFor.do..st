accessing-edge points
leftAndRightEdgePointsFor: anRMapVertex do: aBlock
	| halfWidth |
	halfWidth := (self formFor: anRMapVertex) width / 2.0.
	(rmap projector value: anRMapVertex)
		ifNotNil: [ :position | 
			aBlock value: (position x - halfWidth) @ position y.
			aBlock value: (position x + halfWidth) @ position y ]