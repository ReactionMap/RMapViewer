utilities
jmol: aString captions: aDictionary
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
					OSProcess
						command:
							'java -jar ' , (FileSystem workingDirectory / 'RMapJmol.jar') fullName , ' RMapViewer ' , xyzFile fullName , ' '
								, capFile fullName ] ]