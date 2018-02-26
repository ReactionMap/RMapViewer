substructural matching
executeMatchingCommands: anArrayOfPairs
	^ self
		executeMatchingCommands: anArrayOfPairs
		bonds:
			(bonds
				collect: [ :bond | 
					{(bond atom1).
					(bond atom2)} ])
		atomId: 0