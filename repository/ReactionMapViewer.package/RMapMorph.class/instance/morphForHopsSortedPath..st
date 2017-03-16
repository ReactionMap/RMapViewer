accessing-paths
morphForHopsSortedPath: anArrayOfRMapVertex
	^ (Text
		streamContents: [ :stream | 
			stream nextPutAll: (((anArrayOfRMapVertex size - 1) // 2) printString , ' : ') asText.
			anArrayOfRMapVertex
				do: [ :node | stream nextPutAll: node label asText ]
				separatedBy: [ stream nextPutAll: '->' asText ] ]) asRMapTextLabelMorph