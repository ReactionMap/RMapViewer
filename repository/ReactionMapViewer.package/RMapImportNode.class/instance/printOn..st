printing
printOn: aStream
	label
		ifNotNil: [ 
			aStream
				nextPut: $<;
				nextPutAll: label;
				nextPut: $> ]
		ifNil: [ super printOn: aStream ]