accessing-paths
cvsForEnergySortedPath: anArrayOfRMapVertex
	| baseEnergy peakEnergy peakNode |
	baseEnergy := anArrayOfRMapVertex ifEmpty: [ 0.0 ] ifNotEmpty: [ anArrayOfRMapVertex first kJpermol ].
	peakEnergy := Float fmax negated.
	peakNode := nil.
	anArrayOfRMapVertex
		do: [ :node | 
			| energy |
			energy := node kJpermol - baseEnergy.
			peakEnergy < energy
				ifTrue: [ 
					peakEnergy := energy.
					peakNode := node ] ].
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: peakEnergy printString , ','.
			peakNode ifNotNil: [ stream nextPutAll: peakNode label ].
			stream nextPutAll: ','.
			anArrayOfRMapVertex do: [ :node | stream nextPutAll: node label ] separatedBy: [ stream nextPut: $, ] ]