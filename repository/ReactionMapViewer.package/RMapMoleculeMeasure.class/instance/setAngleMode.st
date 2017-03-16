accessing-modes
setAngleMode
	molecule size < 3
		ifTrue: [ ^ self ].
	measureMode := self angleMode.
	self changed