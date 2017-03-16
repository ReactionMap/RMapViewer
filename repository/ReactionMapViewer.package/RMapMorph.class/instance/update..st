updating
update: anObject
	anObject == rendererSelector
		ifTrue: [ 
			self updateRenderer.
			self changed ]