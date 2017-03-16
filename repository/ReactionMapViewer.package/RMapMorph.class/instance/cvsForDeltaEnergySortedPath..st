accessing-paths
cvsForDeltaEnergySortedPath: anArrayOfRMapVertex
	| peakEnergy peakNode |
	peakEnergy := Float fmax negated.
	peakNode := nil.
	2 to: anArrayOfRMapVertex size by: 2 do: [ :index | 
		| energy |
		energy := (anArrayOfRMapVertex at: index) kJpermol - (anArrayOfRMapVertex at: index - 1) kJpermol.
		peakEnergy < energy
			ifTrue: [ 
				peakEnergy := energy.
				peakNode := anArrayOfRMapVertex at: index ] ].
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: peakEnergy printString , ','.
			peakNode ifNotNil: [ stream nextPutAll: peakNode label ].
			stream nextPutAll: ','.
			anArrayOfRMapVertex do: [ :node | stream nextPutAll: node label ] separatedBy: [ stream nextPut: $, ] ]