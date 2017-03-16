event handling
keyStroke: event
	event keyValue = 125
		ifTrue: [self zoomIn].
	event keyValue = 126
		ifTrue: [self zoomOut].
	^true