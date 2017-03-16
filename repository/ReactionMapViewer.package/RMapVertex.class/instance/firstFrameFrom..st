private
firstFrameFrom: vertex
	self from: vertex framesDo: [ :f | ^ f ].
	^ RMapXYZFrame fromGeometry: self geometry