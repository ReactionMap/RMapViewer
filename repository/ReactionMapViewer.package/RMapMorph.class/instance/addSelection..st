viewer functions
addSelection: anRMapVertex
	(selectedVertices includes: anRMapVertex)
		ifFalse: [ 
			selectedVertices := selectedVertices copyWith: anRMapVertex.
			((products includes: anRMapVertex) or: [ reactants includes: anRMapVertex ])
				ifTrue: [ 
					products := products copyWithout: anRMapVertex.
					reactants := reactants copyWithout: anRMapVertex.
					self updatePaths ].
				 
			self xNumerizer updateSelection.
			self yNumerizer updateSelection.
			self zNumerizer updateSelection.
			self projector updateSelection.
			self changed: #selection  ]