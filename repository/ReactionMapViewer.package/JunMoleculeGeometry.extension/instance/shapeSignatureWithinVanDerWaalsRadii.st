*ReactionMapViewer
shapeSignatureWithinVanDerWaalsRadii
	| sig |
	sig := Dictionary new: atoms size * 4.
	1 to: atoms size - 1 do: [ :i1 | 
		| a1 |
		a1 := atoms at: i1.
		i1 + 1 to: atoms size do: [ :i2 | 
			| a2 d key |
			a2 := atoms at: i2.
			d := a1 position distance: a2 position.
			key := a1 symbol <= a2 symbol
				ifTrue: [ Array with: a1 symbol with: a2 symbol ]
				ifFalse: [ Array with: a2 symbol with: a1 symbol ].
			a1 vanDerWaalsRadius + a2 vanDerWaalsRadius >= d
				ifTrue: [ (sig at: key ifAbsentPut: [ SortedCollection new ]) add: d ] ] ].
	^ sig