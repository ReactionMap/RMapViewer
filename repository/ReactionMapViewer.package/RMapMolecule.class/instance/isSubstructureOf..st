substructural matching
isSubstructureOf: aJunMoleculeGeometry
	| subElementBag superElementBag subBondBag superBondBag |
	subElementBag := (atoms collect: #symbol) asBag.
	superElementBag := ((1 to: aJunMoleculeGeometry size) collect: [ :index | (aJunMoleculeGeometry at: index) symbol ])
		asBag.
	subElementBag
		doWithOccurrences: [ :element :num | 
			(superElementBag occurrencesOf: element) < num
				ifTrue: [ ^ false ] ].
	subBondBag := (bonds
		collect: [ :bond | 
			{(bond atom1 symbol).
			(bond atom2 symbol)} asSortedCollection asArray ]) asBag.
	superBondBag := (Array
		streamContents: [ :stream | 
			aJunMoleculeGeometry
				bondsDo: [ :bond | 
					stream
						nextPut:
							{(bond atom1 symbol).
							(bond atom2 symbol)} asSortedCollection asArray ] ]) asBag.
	subBondBag
		doWithOccurrences: [ :b :o | 
			(superBondBag occurrencesOf: b) < o
				ifTrue: [ ^ true ] ].
	^ aJunMoleculeGeometry executeMatchingCommands: (self generateMatchingCommandsWith: aJunMoleculeGeometry)