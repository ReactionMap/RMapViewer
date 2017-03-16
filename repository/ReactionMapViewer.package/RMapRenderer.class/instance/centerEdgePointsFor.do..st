accessing-edge points
centerEdgePointsFor: anRMapVertex do: aBlock
	(rmap projector value: anRMapVertex) ifNotNil: aBlock