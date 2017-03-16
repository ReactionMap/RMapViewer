utilities
jmol: aString captions: aDictionary energies: anArrayOfFloat
	FileSystem workingDirectory / 'tmp.xyz'
		in: [ :xyzFile | 
			xyzFile ensureDelete.
			xyzFile writeStreamDo: [ :xyzStream | xyzStream nextPutAll: aString ].
			FileSystem workingDirectory / 'tmp.cap'
				in: [ :capFile | 
					capFile ensureDelete.
					capFile
						writeStreamDo: [ :capStream | 
							1 to: aDictionary keys asSortedCollection last do: [ :i | 
								(aDictionary includesKey: i)
									ifTrue: [ capStream nextPutAll: (aDictionary at: i) ].
								capStream lf ] ].
					FileSystem workingDirectory / 'tmp.ene'
						in: [ :energyFile | 
							energyFile ensureDelete.
							energyFile
								writeStreamDo: [ :energyStream | 
									anArrayOfFloat
										do: [ :e | 
											energyStream nextPutAll: e printString.
											energyStream lf ] ].
							OSProcess
								command:
									'java -jar ' , (FileSystem workingDirectory / 'RMapJmol.jar') fullName , ' RMapViewer ' , xyzFile fullName , ' '
										, capFile fullName , ' ' , energyFile fullName ] ] ]