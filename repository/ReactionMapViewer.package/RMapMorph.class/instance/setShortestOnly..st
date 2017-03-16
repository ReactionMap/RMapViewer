accessing-paths
setShortestOnly: aBoolean
	shortestOnly := aBoolean = true.
	self changed: #pathSorter.
	self updatePaths