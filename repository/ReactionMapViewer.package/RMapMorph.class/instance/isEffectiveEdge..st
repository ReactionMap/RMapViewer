testing
isEffectiveEdge: anRMapEdge
	^ (self isEffectiveVertex: anRMapEdge vertex1) and: [ self isEffectiveVertex: anRMapEdge vertex2 ]