operations
search
	| keyMolecule |
	keyMolecule := scratcherMorph moleculeGeometry.
	moleculeList := (rmap vertices select: [ :vertex | keyMolecule isSubstructureOf: vertex asMolecule ])
		asSortedCollection: [ :v1 :v2 | v1 energy <= v2 energy ].
	self sortMoleculeList