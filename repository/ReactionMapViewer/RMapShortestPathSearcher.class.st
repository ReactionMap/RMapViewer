Class {
	#name : #RMapShortestPathSearcher,
	#superclass : #Object,
	#instVars : [
		'reactants',
		'products',
		'rmap'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapShortestPathSearcher class >> on: anRMapMorph [
	^ self new setRMap: anRMapMorph
]

{ #category : #searching }
RMapShortestPathSearcher >> allShortestPathsWith: aDictionary [
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
]

{ #category : #private }
RMapShortestPathSearcher >> edgesWithin: aNumber [
	^ self subclassResponsibility
]

{ #category : #private }
RMapShortestPathSearcher >> energies [
	^ self subclassResponsibility
]

{ #category : #testing }
RMapShortestPathSearcher >> isReachableWith: aDictionary [
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
]

{ #category : #searching }
RMapShortestPathSearcher >> search [
	| energy result |
	reactants ifEmpty: [ ^ Array new ].
	products ifEmpty: [ ^ Array new ].
	energy := self thresholdEnergy.
	rmap progress: 0.25.
	Processor yield.
	energy ifNil: [ ^ Array new ].
	result := self allShortestPathsWith: (self edgesWithin: energy).
	rmap progress: 1.0.
	^ result
]

{ #category : #private }
RMapShortestPathSearcher >> setRMap: anRMapMorph [
	rmap := anRMapMorph.
	reactants := IdentitySet new: 10.
	rmap reactantsDo: [ :vertex | reactants add: vertex ].
	products := IdentitySet new: 10.
	rmap productsDo: [ :vertex | products add: vertex ]
]

{ #category : #private }
RMapShortestPathSearcher >> thresholdEnergy [
	| energies min max |
	energies := self energies.
	min := 1.
	max := energies size.
	[ min = max ]
		whileFalse: [ 
			| index |
			index := (min + max + 1) // 2.
			(self isReachableWith: (self edgesWithin: (energies at: index)))
				ifTrue: [ max := index - 1 ]
				ifFalse: [ min := index ] ].
	^ energies at: min + 1 ifAbsent: [  ]
]
