private
firstFrameTo: vertex
	self to: vertex framesDo: [ :f | ^ f ].
	^ RMapXYZFrame fromGeometry: self geometry