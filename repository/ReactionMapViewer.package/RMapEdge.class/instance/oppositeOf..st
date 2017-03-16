accessing
oppositeOf: vertex
	vertex1 == vertex
		ifTrue: [ ^ vertex2 ].
	vertex2 == vertex
		ifTrue: [ ^ vertex1 ].
	^ nil