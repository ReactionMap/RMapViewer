private
firstFrameFrom: vertex1 to: vertex2
	self from: vertex1 to: vertex2 framesDo: [ :f | ^ f ].
	^ RMapXYZFrame fromGeometry: self geometry