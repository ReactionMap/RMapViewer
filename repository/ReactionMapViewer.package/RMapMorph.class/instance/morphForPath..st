accessing-paths
morphForPath: anArrayOfRMapVertex
	self isEnergyPathSorter ifTrue: [ ^self morphForEnergySortedPath: anArrayOfRMapVertex].
	self isDeltaEnergyPathSorter ifTrue: [ ^self morphForDeltaEnergySortedPath: anArrayOfRMapVertex].
	^self morphForHopsSortedPath: anArrayOfRMapVertex