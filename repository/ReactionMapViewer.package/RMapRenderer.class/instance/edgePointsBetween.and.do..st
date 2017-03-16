accessing-edge points
edgePointsBetween: anRMapVertex1 and: anRMapVertex2 do: aBlock
	| point1 point2 minDistance |
	point1 := nil.
	point2 := nil.
	minDistance := Float fmax.
	self
		edgePointsFor: anRMapVertex1
		do: [ :p1 | 
			self
				edgePointsFor: anRMapVertex2
				do: [ :p2 | 
					| d |
					d := p1 dist: p2.
					d < minDistance
						ifTrue: [ 
							minDistance := d.
							point1 := p1.
							point2 := p2 ] ] ].
	point1 ifNotNil: [ point2 ifNotNil: [ aBlock value: point1 value: point2 ] ]