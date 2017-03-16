accessing
argmaxVertex: aBlock
	^ (vertices
		inject: nil -> Float fmax negated
		into: [ :sofar :vertex | 
			| value |
			value := aBlock value: vertex.
			sofar value < value
				ifTrue: [ vertex -> value ]
				ifFalse: [ sofar ] ]) key