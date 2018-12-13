Class {
	#name : #RMapMolecule,
	#superclass : #JunMoleculeGeometry,
	#instVars : [
		'energy'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #accessing }
RMapMolecule >> energy [
	^ energy
]

{ #category : #accessing }
RMapMolecule >> energy: aNumber [
	energy := aNumber
]

{ #category : #'substructural matching' }
RMapMolecule >> executeMatchingCommands: anArrayOfPairs [
	^ self
		executeMatchingCommands: anArrayOfPairs
		bonds:
			(bonds
				collect: [ :bond | 
					{(bond atom1).
					(bond atom2)} ])
		atomId: 0
]

{ #category : #'substructural matching' }
RMapMolecule >> executeMatchingCommands: anArrayOfAssociations bonds: anArrayOfPairs atomId: anInteger [
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
]

{ #category : #'substructural matching' }
RMapMolecule >> generateMatchingCommandsWith: aJunMoleculeGeometry [
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
					(o1 * o2)} ]
				ifFalse: [ 
					{(bond atom2).
					(bond atom1).
					(o1 * o2)} ] ]) asSortedCollection: [ :less :more | less last <= more last ].
	replaceBlock := [ :a1 :a2 | 
	| o |
	o := superElementBag occurrencesOf: a1 symbol.
	bondsAndWeights
		do: [ :triple | 
					triple first = a1
						ifTrue: [ 
							triple at: 1 put: a2.
							o ~= 0
								ifTrue: [ triple at: 3 put: triple third / o ] ].
					triple second = a1
						ifTrue: [ 
							triple at: 2 put: triple first.
							triple at: 1 put: a2.
							o ~= 0
								ifTrue: [ triple at: 3 put: triple third / o ] ] ];
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
]

{ #category : #'substructural matching' }
RMapMolecule >> isSubstructureOf: aJunMoleculeGeometry [
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
				ifTrue: [ ^ false ] ].
	^ aJunMoleculeGeometry executeMatchingCommands: (self generateMatchingCommandsWith: aJunMoleculeGeometry)
]
