accessing-paths
morphForEnergySortedPath: anArrayOfRMapVertex
	| baseEnergy peakEnergy peakNodeIndex |
	anArrayOfRMapVertex ifEmpty: [ ^ Text new asRMapTextLabelMorph ].
	baseEnergy := anArrayOfRMapVertex first kJpermol.
	peakEnergy := Float fmax negated.
	peakNodeIndex := nil.
	1 to: anArrayOfRMapVertex size do: [ :index | 
		| energy |
		energy := (anArrayOfRMapVertex at: index) kJpermol - baseEnergy.
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