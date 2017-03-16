viewer functions
addProduct: anRMapVertex
	(products includes: anRMapVertex)
		ifFalse: [ 
			selectedVertices := selectedVertices copyWithout: anRMapVertex.
			products := products copyWith: anRMapVertex.
			reactants := reactants copyWithout: anRMapVertex.
			self updatePaths.
			 
			self xNumerizer updateSelection.
			self yNumerizer updateSelection.
			self zNumerizer updateSelection.
			self projector updateSelection.
			self changed: #selection  ]