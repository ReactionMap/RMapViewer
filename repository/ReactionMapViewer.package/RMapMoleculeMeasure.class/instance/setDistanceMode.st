accessing-modes
setDistanceMode
	molecule size < 2
		ifTrue: [ ^ self ].
	measureMode := self distanceMode.
	self changed