private
search: anArrayOfRMapVertex score: aNumber into: aSortedCollection from: from to: to
	anArrayOfRMapVertex size <= (maxNumberOfHops * 2)
		ifTrue: [ 
			| last delta progress |
			searchProgress value: from.
			Processor yield.
			last := anArrayOfRMapVertex last.
			delta := (to - from) / last numEdges.
			progress := from.
			anArrayOfRMapVertex last
				edgesDo: [ :edge | 
					| v |
					v := last == edge vertex1
						ifTrue: [ edge vertex2 ]
						ifFalse: [ edge vertex1 ].
					((anArrayOfRMapVertex includes: v) not and: [ self isEffectiveVertex: v ])
						ifTrue: [ 
							| s |
							s := aNumber
								max:
									(self isEnergyPathSorter
										ifTrue: [ v energy ]
										ifFalse: [ 
											self isDeltaEnergyPathSorter
												ifTrue: [ v energy - last energy ]
												ifFalse: [ anArrayOfRMapVertex size + 1 ] ]).
							(aSortedCollection size < maxNumberOfPaths or: [ s < aSortedCollection last value ])
								ifTrue: [ 
									| newPath |
									newPath := anArrayOfRMapVertex copyWith: v.
									(self hasProduct: v)
										ifTrue: [ 
											aSortedCollection add: newPath -> s.
											[ aSortedCollection size > maxNumberOfPaths ] whileTrue: [ aSortedCollection removeLast ] ]
										ifFalse: [ self search: newPath score: s into: aSortedCollection from: progress to: progress + delta ] ] ].
					progress := progress + delta ] ]