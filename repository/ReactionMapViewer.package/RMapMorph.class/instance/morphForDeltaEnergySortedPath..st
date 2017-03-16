accessing-paths
morphForDeltaEnergySortedPath: anArrayOfRMapVertex
	| peakEnergy peakNodeIndex |
	anArrayOfRMapVertex ifEmpty: [ ^ Text new asRMapTextLabelMorph  ].
	peakEnergy := Float fmax negated.
	peakNodeIndex := nil.
	2 to: anArrayOfRMapVertex size by: 2 do: [ :index | 
		| energy |
		energy := (anArrayOfRMapVertex at: index) kJpermol - (anArrayOfRMapVertex at: index - 1) kJpermol.
		peakEnergy < energy
			ifTrue: [ 
				peakEnergy := energy.
				peakNodeIndex := index ] ].
	^ (Text
		streamContents: [ :stream | 
			stream nextPutAll: ((peakEnergy printShowingDecimalPlaces: 1) , 'kJ/mol : ') asText.
			(1 to: anArrayOfRMapVertex size)
				do: [ :index | 
					| node |
					node := anArrayOfRMapVertex at: index.
					stream
						nextPutAll:
							(index = peakNodeIndex
								ifTrue: [ 
									node label asText
										makeAllColor: Color red;
										allBold;
										yourself ]
								ifFalse: [ node label asText ]) ]
				separatedBy: [ stream nextPutAll: '->' asText ] ]) asRMapTextLabelMorph