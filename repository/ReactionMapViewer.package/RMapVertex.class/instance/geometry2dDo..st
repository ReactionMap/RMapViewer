private
geometry2dDo: aBlock
	| a f f1 f2 f3 |
	a := DhbMatrix rows: (self geometryMatrix).
	f := (a transpose * a) orthogonalize.
	f1 := f numberOfColumns >= 1
		ifTrue: [ f columnAt: 1 ]
		ifFalse: [ DhbVector with: 0.0 with: 0.0 with: 0.0 ].
	f2 := f numberOfColumns >= 2
		ifTrue: [ f columnAt: 2 ]
		ifFalse: [ DhbVector with: 0.0 with: 0.0 with: 0.0 ].
	f3 := f numberOfColumns >= 3
		ifTrue: [ f columnAt: 3 ]
		ifFalse: [ DhbVector with: 0.0 with: 0.0 with: 0.0 ].
	self
		geometryDo: [ :atom :x :y :z | 
			| v |
			v := DhbVector with: x with: y with: z.
			aBlock
				value: atom
				value: f1 * v
				value: f2 * v
				value: f3 * v ]