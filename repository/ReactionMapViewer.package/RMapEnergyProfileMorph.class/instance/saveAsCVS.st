operations
saveAsCVS
	(UIManager default
		fileSave: 'Choose a file to save'
		extensions: #('cvs')
		path: (Smalltalk os environment at: 'HOME' ifAbsent: '/'))
		ifNotNil: [ :fileReference | 
			| writeStream endOfLine |
			writeStream := fileReference writeStream.
			writeStream ascii.
			endOfLine := Smalltalk platform lineEnding.
			motionMolecule
				do: [ :molecule | 
					molecule label
						ifNotNil: [ :caption | 
							writeStream
								nextPut: $";
								nextPutAll: caption;
								nextPutAll: '",';
								nextPutAll: molecule energy printString;
								nextPutAll: endOfLine ] ] ]