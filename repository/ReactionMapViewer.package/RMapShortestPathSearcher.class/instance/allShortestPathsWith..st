searching
allShortestPathsWith: aDictionary
	| done agenda paths |
	done := IdentitySet new: aDictionary size.
	done addAll: reactants.
	agenda := reactants asArray collect: [ :v | Array with: v ].
	paths := Array new writeStream.
	[ agenda notEmpty ]
		whileTrue: [ 
			| newAgenda newDone |
			newAgenda := Array new writeStream.
			newDone := Array new writeStream.
			agenda
				do: [ :path | 
					(aDictionary at: path last ifAbsent: [ #() ])
						do: [ :peer | 
							(done includes: peer) not
								ifTrue: [ 
									| newPath |
									newDone nextPut: peer.
									newPath := path copyWith: peer.
									((products includes: peer)
										ifTrue: [ paths ]
										ifFalse: [ newAgenda ]) nextPut: newPath ] ] ].
			paths position > 0
				ifTrue: [ ^ paths contents ].
			Processor yield.
			agenda := newAgenda contents.
			done addAll: newDone contents ].
	^ paths