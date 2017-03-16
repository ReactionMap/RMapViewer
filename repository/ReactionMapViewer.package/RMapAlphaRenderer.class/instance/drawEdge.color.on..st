drawing
drawEdge: anRMapEdge color: aColor on: aCanvas
	| z1 z2 |
	z1 := rmap zNumerizer value: anRMapEdge vertex1.
	z2 := rmap zNumerizer value: anRMapEdge vertex2.
	z1 ifNil: [ z1 := z2 ].
	z2 ifNil: [ z2 := z1 ].
	z1 ifNil: [ ^ self ].
	super drawEdge: anRMapEdge color: aColor on: (aCanvas asAlphaBlendingCanvas: ((2.0 - z1 - z2) * 0.4 + 0.2 min: 1.0 max: 0.0))