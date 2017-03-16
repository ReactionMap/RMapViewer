viewer functions
selections: aCollectionOfRMapVertex
	selectedVertices := Array withAll: aCollectionOfRMapVertex.
	self xNumerizer updateSelection.
	self yNumerizer updateSelection.
	self zNumerizer updateSelection.
	self projector updateSelection.
	self changed: #selection