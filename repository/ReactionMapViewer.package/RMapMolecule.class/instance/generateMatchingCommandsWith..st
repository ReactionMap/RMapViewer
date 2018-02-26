substructural matching
generateMatchingCommandsWith: aJunMoleculeGeometry
	| superElementBag bondsAndWeights replaceBlock atomId atom commands |
	superElementBag := ((1 to: aJunMoleculeGeometry size) collect: [ :index | (aJunMoleculeGeometry at: index) symbol ])
		asBag.
	bondsAndWeights := (bonds
		collect: [ :bond | 
			| o1 o2 |
			o1 := superElementBag occurrencesOf: bond atom1 symbol.
			o2 := superElementBag occurrencesOf: bond atom2 symbol.
			o1 <= o2
				ifTrue: [ 
					{(bond atom1).
					(bond atom2).
					(o1 + o2)} ]
				ifFalse: [ 
					{(bond atom2).
					(bond atom1).
					(o1 + o2)} ] ]) asSortedCollection: [ :less :more | less last <= more last ].
	replaceBlock := [ :a1 :a2 | 
	| o |
	o := superElementBag occurrencesOf: a1 symbol.
	bondsAndWeights
		do: [ :triple | 
					triple first = a1
						ifTrue: [ 
							triple at: 1 put: a2.
							triple at: 3 put: triple third - o + 1 ].
					triple second = a1
						ifTrue: [ 
							triple at: 2 put: triple first.
							triple at: 1 put: a2.
							triple at: 3 put: triple third - o + 1 ] ];
		reSort ].
	atomId := 0.
	atom := nil.
	commands := OrderedCollection new: bondsAndWeights size.
	[ bondsAndWeights notEmpty ]
		whileTrue: [ 
			| bond atom1 atom2 |
			atom1 := atom.
			bond := bondsAndWeights
				detect: [ :triple | triple first = atom1 or: [ triple second = atom1 ] ]
				ifNone: [ 
					| b |
					b := bondsAndWeights first.
					atom := b first.
					atom1 := atom.
					atom1 isInteger
						ifFalse: [ 
							replaceBlock value: atom1 value: (atomId := atomId + 1).
							atom1 := atomId ].
					b ].
			bondsAndWeights remove: bond.
			atom2 := bond first = atom1
				ifTrue: [ bond second ]
				ifFalse: [ bond first ].
			commands
				add:
					(atom isInteger
						ifTrue: [ atom ]
						ifFalse: [ atom symbol ])
						->
							(atom2 isInteger
								ifTrue: [ atom2 ]
								ifFalse: [ atom2 symbol ]).
			atom2 isInteger
				ifFalse: [ 
					replaceBlock value: atom2 value: (atomId := atomId + 1).
					atom2 := atomId ].
			atom := atom2 ].
	^ commands