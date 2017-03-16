accessing
edgePointsFor: anRMapVertex do: aBlock
	anRMapVertex label first = $E
		ifTrue: [ self centerEdgePointsFor: anRMapVertex do: aBlock ]
		ifFalse: [ self leftAndRightEdgePointsFor: anRMapVertex do: aBlock ]