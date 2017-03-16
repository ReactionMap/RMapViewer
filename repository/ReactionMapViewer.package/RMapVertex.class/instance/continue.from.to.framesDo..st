enumerating
continue: frame from: vertex1 to: vertex2 framesDo: aBlock
	| transformation |
	transformation := frame transformationBlockWith: (self firstFrameFrom: vertex1 to: vertex2).
	self
		from: vertex1
		to: vertex2
		framesDo: [ :f | 
			aBlock
				value:
					(Array new writeStream
						in: [ :transformedAtoms | 
							f atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (transformation value: point) ].
							RMapXYZFrame from: transformedAtoms contents ]) ]