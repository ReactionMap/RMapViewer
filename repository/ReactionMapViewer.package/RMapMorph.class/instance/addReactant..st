viewer functions
addReactant: anRMapVertex
	(reactants includes: anRMapVertex)
		ifFalse: [ 
			selectedVertices := selectedVertices copyWithout: anRMapVertex.
			products := products copyWithout: anRMapVertex.
			reactants := reactants copyWith: anRMapVertex.
			self updatePaths.
			 
			self xNumerizer updateSelection.
			self yNumerizer updateSelection.
			self zNumerizer updateSelection.
			self projector updateSelection.
			self changed: #selection  ]