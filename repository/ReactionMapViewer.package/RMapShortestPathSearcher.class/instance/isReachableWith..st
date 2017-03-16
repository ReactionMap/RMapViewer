testing
isReachableWith: aDictionary
	| agenda done |
	agenda := OrderedCollection new: 100.
	agenda addAll: reactants.
	done := IdentitySet new: rmap vertices size.
	[ agenda notEmpty ]
		whileTrue: [ 
			| newAgenda |
			newAgenda := OrderedCollection new: 100.
			agenda
				do: [ :vertex | 
					(aDictionary at: vertex ifAbsent: [ #() ])
						do: [ :peer | 
							(products includes: peer)
								ifTrue: [ ^ true ].
							(done includes: peer)
								ifFalse: [ 
									done add: peer.
									newAgenda add: peer ] ] ].
			agenda := newAgenda ].
	^ false