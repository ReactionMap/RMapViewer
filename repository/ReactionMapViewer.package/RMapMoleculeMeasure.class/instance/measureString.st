accessing
measureString
	self isDistanceMode
		ifTrue: [ ^ self distanceString ].
	self isAngleMode
		ifTrue: [ ^ self angleString ].
	self isDihedralAngleMode
		ifTrue: [ ^ self dihedralAngleString ].
	^ 'N/A' copy