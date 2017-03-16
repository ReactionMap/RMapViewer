*ReactionMapViewer
fullShapeSignatureWithBondCorrection
	| sig |
	sig := Dictionary new: atoms size * (atoms size - 1) // 2.
	1 to: atoms size - 1 do: [ :i1 | 
		| a1 |
		a1 := atoms at: i1.
		i1 + 1 to: atoms size do: [ :i2 | 
			| a2 d key |
			a2 := atoms at: i2.
			d := (self bondBetween: a1 and: a2 ifAbsent: [  ])
				ifNil: [ a1 position distance: a2 position ]
				ifNotNil: [ :b |Transcript cr; show: 'bond', b order printString. (a1 covalentRadiusOfOrder: b order) + (a2 covalentRadiusOfOrder: b order) ].
			key := a1 symbol <= a2 symbol
				ifTrue: [ Array with: a1 symbol with: a2 symbol ]
				ifFalse: [ Array with: a2 symbol with: a1 symbol ].
			(sig at: key ifAbsentPut: [ SortedCollection new ]) add: d ] ].
	^ sig