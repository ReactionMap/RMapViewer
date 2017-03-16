*ReactionMapViewer-GRRMImport
readEQs: aFileReference
	^ Array
		new: 1024
		streamContents: [ :eqStream | 
			aFileReference
				readStreamDo: [ :logStream | 
					| eq |
					eq := nil.
					logStream contents
						linesDo: [ :line | 
							('# Geometry of *' match: line)
								ifTrue: [ 
									eq := RMapImportEQ new.
									eq label: 'EQ' , eqStream position printString ]
								ifFalse: [ 
									('Energy*' match: line)
										ifTrue: [ 
											eq energy: (line substrings: '=') second trim.
											eqStream nextPut: eq.
											eq := nil ]
										ifFalse: [ 
											eq
												ifNotNil: [ 
													| items |
													items := line substrings.
													eq geometryAdd: items ] ] ] ] ] ]