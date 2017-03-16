event handling
keyStroke: event
	event keyValue = 125
		ifTrue: [rmapMorph zoomIn].
	event keyValue = 126
		ifTrue: [rmapMorph zoomOut].
	^true