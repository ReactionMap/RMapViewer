transformation
transform: anRMapXYZFrame
	| block |
	block := self transformationBlockWith: anRMapXYZFrame.
	^ Array new writeStream
		in: [ :transformedAtoms | 
			anRMapXYZFrame atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (block value: point) ].
			self class from: transformedAtoms contents ]