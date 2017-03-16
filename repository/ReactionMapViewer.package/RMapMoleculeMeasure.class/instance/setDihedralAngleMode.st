accessing-modes
setDihedralAngleMode
	molecule size < 4
		ifTrue: [ ^ self ].
	measureMode := self dihedralAngleMode.
	self changed