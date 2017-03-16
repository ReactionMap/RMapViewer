private
edgesWithin: aNumber
	| edges |
	edges := IdentityDictionary new: rmap vertices size.
	rmap
		edgesDo: [ :edge | 
			edge vertex2 energy - edge vertex1 energy <= aNumber
				ifTrue: [ (edges at: edge vertex1 ifAbsentPut: [ OrderedCollection new: 10 ]) add: edge vertex2 ].
			edge vertex1 energy - edge vertex2 energy <= aNumber
				ifTrue: [ (edges at: edge vertex2 ifAbsentPut: [ OrderedCollection new: 10 ]) add: edge vertex1 ] ].
	^ edges