testing
activeAtomsIncludes: aJunAtom
	1 to: self activeAtomsSize do: [ :index | 
		(atoms at: index) == aJunAtom
			ifTrue: [ ^ true ] ].
	^ false