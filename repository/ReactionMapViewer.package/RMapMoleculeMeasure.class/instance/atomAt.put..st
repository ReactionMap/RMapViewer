accessing-atoms
atomAt: anInteger put: aJunAtom
	1 to: atoms size do: [ :index | 
		(index ~= anInteger and: [ (atoms at: index) == aJunAtom ])
			ifTrue: [ atoms at: index put: (atoms at: anInteger) ] ].
	atoms at: anInteger put: aJunAtom.
	self changed.
	^ aJunAtom