operations
sortMoleculeList
	moleculeList := self sortByEnergy
		ifTrue: [ moleculeList asSortedCollection: [ :v1 :v2 | v1 energy <= v2 energy ] ]
		ifFalse: [ 
			| keySignature errors |
			keySignature := scratcherMorph moleculeGeometry fullShapeSignatureWithBondCorrection.
			errors := OrderedCollection new: moleculeList size.
			moleculeList
				do: [ :vertex | 
					| signature error |
					signature := vertex fullShapeSignature.
					error := 0.0.
					keySignature
						keysAndValuesDo: [ :atoms :distances1 | 
							signature
								at: atoms
								ifPresent: [ :distances2 | 
									1 to: (distances1 size min: distances2 size) do: [ :i | 
										| d1 d2 |
										d1 := distances1 at: i.
										d2 := distances2 at: i.
										error := (d1 - d2) abs / (d1 max: d2) + error ].
									error := (distances1 size - distances2 size) abs + error ]
								ifAbsent: [ error := distances1 size + error ] ].
					signature
						keysAndValuesDo: [ :atoms :distances2 | keySignature at: atoms ifAbsent: [ error := distances2 size + error ] ].
					errors add: error -> vertex ].
			errors asSortedCollection collect: #value ].
	primarySelectionIndex := 0.
	listSelection := Set new.
	self changed: #moleculeList.
	self changed: #listSelection.
	self changed: #primarySelectionIndex