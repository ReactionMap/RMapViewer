*ReactionMapViewer-GRRMImport
readDCs: aFileReference EQs: eqs
	^ Array
		new: 1024
		streamContents: [ :dcStream | 
			aFileReference
				readStreamDo: [ :logStream | 
					| dc geometryMode |
					dc := nil.
					geometryMode := false.
					logStream contents
						linesDo: [ :line | 
							('# Geometry of *' match: line)
								ifTrue: [ 
									geometryMode := true.
									dc := RMapImportDC new.
									dc label: 'DC' , dcStream position printString.
									dcStream nextPut: dc ]
								ifFalse: [ 
									('Energy*' match: line)
										ifTrue: [ dc energy: (line substrings: '=') second trim asNumber asFloat. geometryMode := false ]
										ifFalse: [ 
											('CONNECTION*' match: line)
												ifTrue: [ 
													| start end |
													start := (line indexOf: $:) + 1.
													end := (line indexOf: $-) - 1.
													dc eq: (eqs at: (line copyFrom: start to: end) trim asNumber asInteger + 1).
													dc := nil ]
												ifFalse: [ 
													geometryMode
														ifTrue: [ 
															| items |
															items := line substrings.
															dc geometryAdd: items ] ] ] ] ] ] ]