Class {
	#name : #RMapMinEnergyGapFromReactants,
	#superclass : #RMapVertexNumerizer,
	#instVars : [
		'energies'
	],
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapMinEnergyGapFromReactants >> energies [
	^ energies
		ifNil: [ 
			| done agenda edict max |
			edict := IdentityDictionary new.
			done := IdentitySet new: rmap vertices size.
			rmap
				reactantsDo: [ :v | 
					done add: v.
					edict at: v put: 0.0 ].
			agenda := (done asArray collect: [ :v | v -> 0.0 ]) asSortedCollection: [ :less :more | less value <= more value ].
			[ agenda notEmpty ]
				whileTrue: [ 
					| assoc |
					assoc := agenda removeFirst.
					assoc key
						neighborsDo: [ :peer | 
							(done includes: peer) not
								ifTrue: [ 
									| de |
									de := assoc value max: peer energy - assoc key energy.
									done add: peer.
									edict at: peer put: de.
									agenda add: peer -> de.
									max := de ] ] ].
			energies :=edict  collect: [ :e | e / max]]
]

{ #category : #accessing }
RMapMinEnergyGapFromReactants >> name [
	^ 'max energy gap'
]

{ #category : #accessing }
RMapMinEnergyGapFromReactants >> reset [
	energies := nil
]

{ #category : #accessing }
RMapMinEnergyGapFromReactants >> update [
	energies := nil
]

{ #category : #accessing }
RMapMinEnergyGapFromReactants >> updateSelection [
	self transitionLinearTo: self copy reset
]

{ #category : #accessing }
RMapMinEnergyGapFromReactants >> value: anRMapVertex [
	^ self energies at: anRMapVertex ifAbsent: [  ]
]
