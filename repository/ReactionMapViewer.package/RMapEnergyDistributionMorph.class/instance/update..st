updating
update: aSymbol
	(aSymbol = #visibleEnergyRangeMin or: [ aSymbol = #visibleEnergyRangeMax ])
		ifTrue: [ self changed ].
	aSymbol = #rmap
		ifTrue: [ self updateDistribution ]