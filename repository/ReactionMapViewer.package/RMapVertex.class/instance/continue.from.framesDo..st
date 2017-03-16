enumerating
continue: frame from: vertex framesDo: aBlock
	| transformation |
	transformation := frame transformationBlockWith: (self firstFrameFrom: vertex).
	self
		from: vertex
		framesDo: [ :f | 
			aBlock
				value:
					(Array new writeStream
						in: [ :transformedAtoms | 
							f atomsDo: [ :atom :point | transformedAtoms nextPut: atom -> (transformation value: point) ].
							RMapXYZFrame from: transformedAtoms contents ]) ]