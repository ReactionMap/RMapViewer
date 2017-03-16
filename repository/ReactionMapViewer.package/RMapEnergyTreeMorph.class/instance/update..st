updating
update: aSymbol
	(#(#selection #visibleEnergyRangeMin #visibleEnergyRangeMax #index #paths) includes: aSymbol)
		ifTrue: [ 
			self updateExtent.
			self changed ]