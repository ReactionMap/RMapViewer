printing
printOn: aStream
	aStream nextPut: $<.
	vertex1 ifNotNil: [ vertex1 label ifNotNil: [ aStream nextPutAll: vertex1 label ] ].
	aStream nextPut: $-.
	vertex2 ifNotNil: [ vertex2 label ifNotNil: [ aStream nextPutAll: vertex2 label ] ].
	aStream nextPut: $>.
