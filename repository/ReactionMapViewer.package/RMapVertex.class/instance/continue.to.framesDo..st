enumerating
continue: frame to: vertex framesDo: aBlock
	| transformation |
	transformation := frame transformationBlockWith: (self firstFrameTo: vertex).
	self
		to: vertex
		framesDo: [ :f | 
			aBlock
				value:
					(Array new writeStream
						in: [ :transformedAtoms | 
							f atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (transformation value: point) ].
							RMapXYZFrame from: transformedAtoms contents ]) ]