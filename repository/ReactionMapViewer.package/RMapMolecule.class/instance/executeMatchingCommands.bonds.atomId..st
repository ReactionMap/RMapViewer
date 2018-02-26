substructural matching
executeMatchingCommands: anArrayOfAssociations bonds: anArrayOfPairs atomId: anInteger
	| atomMatchingBlock replaceBlock |
	anArrayOfAssociations isEmpty
		ifTrue: [ ^ true ].
	atomMatchingBlock := [ :a1 :a2 | 
	a1 isInteger
		ifTrue: [ a1 = a2 ]
		ifFalse: [ a2 isInteger not and: [ a1 = a2 symbol ] ] ].
	replaceBlock := [ :bs :a1 :a2 | 
	bs
		collect: [ :pair | 
			{((pair first isInteger not and: [ pair first == a1 ])
				ifTrue: [ a2 ]
				ifFalse: [ pair first ]).
			((pair second isInteger not and: [ pair second == a1 ])
				ifTrue: [ a2 ]
				ifFalse: [ pair second ])} ] ].
	anArrayOfAssociations first
		in: [ :command | 
			| from to |
			from := command key.
			to := command value.
			anArrayOfPairs
				do: [ :pair | 
					((atomMatchingBlock value: from value: pair first) and: [ atomMatchingBlock value: to value: pair second ])
						ifTrue: [ 
							| atomId newBonds |
							atomId := anInteger.
							newBonds := anArrayOfPairs copyWithout: pair.
							pair first isInteger
								ifFalse: [ newBonds := replaceBlock value: newBonds value: pair first value: (atomId := atomId + 1) ].
							pair second isInteger
								ifFalse: [ newBonds := replaceBlock value: newBonds value: pair second value: (atomId := atomId + 1) ].
							(self executeMatchingCommands: anArrayOfAssociations copyWithoutFirst bonds: newBonds atomId: atomId)
								ifTrue: [ ^ true ] ].
					((atomMatchingBlock value: from value: pair second) and: [ atomMatchingBlock value: to value: pair first ])
						ifTrue: [ 
							| atomId newBonds |
							atomId := anInteger.
							newBonds := anArrayOfPairs copyWithout: pair.
							pair second isInteger
								ifFalse: [ newBonds := replaceBlock value: newBonds value: pair second value: (atomId := atomId + 1) ].
							pair first isInteger
								ifFalse: [ newBonds := replaceBlock value: newBonds value: pair first value: (atomId := atomId + 1) ].
							(self executeMatchingCommands: anArrayOfAssociations copyWithoutFirst bonds: newBonds atomId: atomId)
								ifTrue: [ ^ true ] ] ] ].
	^ false