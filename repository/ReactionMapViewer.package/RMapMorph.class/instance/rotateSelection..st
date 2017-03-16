private
rotateSelection: anRMapVertex
	[ 
	anRMapVertex flushForms.
	(selectedVertices includes: anRMapVertex)
		ifTrue: [ 
			selectedVertices := selectedVertices copyWithout: anRMapVertex.
			reactants := reactants copyWith: anRMapVertex.
			self updatePaths.
			^ self ].
	(reactants includes: anRMapVertex)
		ifTrue: [ 
			reactants := reactants copyWithout: anRMapVertex.
			products := products copyWith: anRMapVertex.
			self updatePaths.
			^ self ].
	(products includes: anRMapVertex)
		ifTrue: [ 
			products := products copyWithout: anRMapVertex.
			self updatePaths.
			^ self ].
	selectedVertices := selectedVertices copyWith: anRMapVertex ]
		ensure: [ 
			self xNumerizer updateSelection.
			self yNumerizer updateSelection.
			self zNumerizer updateSelection.
			self projector updateSelection.
			self changed: #selection ]