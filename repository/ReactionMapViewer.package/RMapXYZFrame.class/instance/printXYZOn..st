converting
printXYZOn: aStream
	atoms size printOn: aStream.
	aStream cr.
	aStream cr.
	self
		atomsDo: [ :atom :point | 
			aStream nextPutAll: atom.
			aStream tab.
			point x printOn: aStream.
			aStream tab.
			point y printOn: aStream.
			aStream tab.
			point z printOn: aStream.
			aStream cr ]