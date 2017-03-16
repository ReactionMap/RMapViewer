printing
printOn: aStream
	aStream nextPut: $<.
	json at: 'label' ifPresent: [:label | aStream nextPutAll: label ].
	aStream nextPut: $>