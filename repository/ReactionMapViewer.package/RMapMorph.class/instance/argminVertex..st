accessing
argminVertex: aBlock
	^ (vertices
		inject: nil -> Float fmax
		into: [ :sofar :vertex | 
			| value |
			value := aBlock value: vertex.
			value < sofar value
				ifTrue: [ vertex -> value ]
				ifFalse: [ sofar ] ]) key