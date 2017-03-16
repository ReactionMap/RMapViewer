instance creation
on: anRMapMorph from: anRMapVertexNumerizer1 to: anRMapVertexNumerizer2 setter: aSymbol
	^ (self on: anRMapMorph setter: aSymbol)
		from: anRMapVertexNumerizer1 to: anRMapVertexNumerizer2;
		yourself