accessing-paths
cvsForPath: anArrayOfRMapVertex
	self isEnergyPathSorter ifTrue: [ ^self cvsForEnergySortedPath: anArrayOfRMapVertex].
	self isDeltaEnergyPathSorter ifTrue: [ ^self cvsForDeltaEnergySortedPath: anArrayOfRMapVertex].
	^self cvsForHopsSortedPath: anArrayOfRMapVertex