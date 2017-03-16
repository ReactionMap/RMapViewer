instance creation
on: anRMapMorph setter: aSymbol sorter: anRMapSimilaritySorter
	^ (self on: anRMapMorph setter: aSymbol)
		setSorter: anRMapSimilaritySorter;
		yourself