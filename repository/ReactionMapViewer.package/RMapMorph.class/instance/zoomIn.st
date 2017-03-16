viewer functions
zoomIn
	viewScale := viewScale * 1.1.
	self updateRenderer.
	self changed: #view