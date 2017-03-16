*ReactionMapViewer-GRRMImport
readTSs: aFileReference EQs: eqs
	^ Array
		new: 1024
		streamContents: [ :tsStream | 
			aFileReference
				readStreamDo: [ :logStream | 
					| id ts geometryMode |
					id := 0.
					ts := nil.
					geometryMode := false.
					logStream contents
						linesDo: [ :line | 
							('# Geometry of *' match: line)
								ifTrue: [ 
									geometryMode := true.
									ts := RMapImportTS new.
									ts label: 'TS' , id printString.
									id := id + 1.
									tsStream nextPut: ts ]
								ifFalse: [ 
									('Energy*' match: line)
										ifTrue: [ 
											ts energy: (line substrings: '=') second trim asNumber asFloat.
											geometryMode := false ]
										ifFalse: [ 
											('CONNECTION*' match: line)
												ifTrue: [ 
													| start end eq1 eq2 |
													start := (line indexOf: $:) + 1.
													end := (line indexOf: $-) - 1.
													([ 
													eq1 := (line copyFrom: start to: end) trim asNumber asInteger + 1.
													eq2 := (line copyFrom: end + 2 to: line size) trim asNumber asInteger + 1.
													true ]
														on: Error
														do: [ :ex | false ])
														ifTrue: [ 
															ts eq1: (eqs at: eq1).
															ts eq2: (eqs at: eq2) ]
														ifFalse: [ tsStream position: tsStream position - 1 ].
													ts := nil ]
												ifFalse: [ 
													geometryMode
														ifTrue: [ 
															| items |
															items := line substrings.
															ts geometryAdd: items ] ] ] ] ] ] ]