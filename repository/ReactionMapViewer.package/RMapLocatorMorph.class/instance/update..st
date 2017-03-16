updating
update: aSymbol
	(#(view visibleEnergyRangeMin visibleEnergyRangeMax) includes: aSymbol)
		ifTrue: [ self changed ]