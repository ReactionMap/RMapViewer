accessing-atoms
activeAtomsSize
	self isDistanceMode
		ifTrue: [ ^ 2 ].
	self isAngleMode
		ifTrue: [ ^ 3 ].
	self isDihedralAngleMode
		ifTrue: [ ^ 4 ].
	^ 0