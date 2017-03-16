accessing-paths
cvsForHopsSortedPath: anArrayOfRMapVertex
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: (anArrayOfRMapVertex size - 1 // 2) printString , ',,'.
			anArrayOfRMapVertex do: [ :node | stream nextPutAll: node label ] separatedBy: [ stream nextPut: $, ] ]