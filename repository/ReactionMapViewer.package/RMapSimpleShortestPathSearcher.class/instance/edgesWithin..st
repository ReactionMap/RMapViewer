private
edgesWithin: aNumber
	| edges |
	edges := IdentityDictionary new: rmap vertices size.
	rmap
		edgesDo: [ :edge | 
			(edges at: edge vertex1 ifAbsentPut: [ OrderedCollection new: 10 ]) add: edge vertex2.
			(edges at: edge vertex2 ifAbsentPut: [ OrderedCollection new: 10 ]) add: edge vertex1 ].
	^ edges