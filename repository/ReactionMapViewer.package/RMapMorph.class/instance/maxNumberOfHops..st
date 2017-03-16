accessing-paths
maxNumberOfHops: anInteger
	maxNumberOfHops := anInteger max: 0.
	self changed: #maxNumberOfHops.
	self updatePaths