updating
changed: aSymbol
	super changed: aSymbol.
	self dependents do: [:aDependent | aDependent update: aSymbol].
	(aSymbol = #visibleEnergyRangeMin or: [ aSymbol = #visibleEnergyRangeMax ])
		ifTrue: [ self updatePaths ]