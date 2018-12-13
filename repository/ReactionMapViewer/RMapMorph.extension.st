Extension { #name : #RMapMorph }

{ #category : #'*ReactionMapViewer-GRRMImport' }
RMapMorph class >> fromDirectory: aFileReference [
	| prefix rmap eqs0 eqs dcs tss nodes numGrids gap |
	prefix := (aFileReference filesMatching: '*.com')
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :refs | refs first basenameWithoutExtension ].
	rmap := self new.
	rmap extent: 500 @ 500.
	eqs0 := self readEQs: aFileReference / (prefix , '_EQ_list.log').
	dcs := self readDCs: aFileReference / (prefix , '_DC_list.log') EQs: eqs0.
	dcs
		do: [ :dc | aFileReference / (prefix , '_' , dc label , '.log') readStreamDo: [ :stream | dc readMultiframe: stream ] ].
	tss := self readTSs: aFileReference / (prefix , '_TS_list.log') EQs: eqs0.
	tss
		do: [ :ts | aFileReference / (prefix , '_' , ts label , '.log') readStreamDo: [ :stream | ts readMultiframe: stream ] ].
	eqs0
		do: [ :eq | 
			Transcript
				cr;
				show: eq label.
			eq readBabel ].
	dcs
		do: [ :dc | 
			Transcript
				cr;
				show: dc label.
			dc readBabel ].
	tss
		do: [ :ts | 
			Transcript
				cr;
				show: ts label.
			ts readBabel ].
	numGrids := (eqs0 size sqrt ceiling + 0.5) asInteger.
	gap := 1.0 / numGrids.
	eqs := (eqs0
		,
			(Array
				new: numGrids * numGrids - eqs0 size
				streamContents: [ :stream | numGrids * numGrids - eqs0 size timesRepeat: [ stream nextPut: RMapImportEQ new ] ]))
		shuffle.
	0 to: eqs size - 1 do: [ :index | 
		| eq x y |
		eq := eqs at: index + 1.
		x := index \\ numGrids.
		y := index // numGrids.
		x odd
			ifTrue: [ y := y + 0.5 ].
		eq position: (x + 0.5) * gap , ((y + 0.5) * gap).
		eq gap: gap ].
	[ 
	| changed |
	changed := false.
	eqs
		do: [ :eq | 
			(eq arrange: eqs)
				ifTrue: [ changed := true ] ].
	changed ] whileTrue.
	nodes := eqs0 , dcs , tss.
	tss do: [ :ts | ts position: (ts eq1 position + ts eq2 position) * 0.5 ].
	dcs do: [ :dc | dc position: dc eq position ].
	tss do: [ :ts | ts arrange: nodes ].
	dcs do: [ :dc | dc arrange: nodes ].
	tss do: [ :ts | ts arrange: nodes ].
	dcs do: [ :dc | dc arrange: nodes ].
	rmap := self new.
	rmap extent: 500 @ 500.
	nodes do: [ :node | rmap addVertex: node asRMapVertex ].
	dcs do: [ :dc | rmap addEdgeBetween: (nodes indexOf: dc) and: (nodes indexOf: dc eq) ].
	tss
		do: [ :ts | 
			rmap addEdgeBetween: (nodes indexOf: ts) and: (nodes indexOf: ts eq1).
			rmap addEdgeBetween: (nodes indexOf: ts) and: (nodes indexOf: ts eq2) ].
	aFileReference / (prefix , '.com') readStreamDo: [ :stream | rmap grrm: stream contents ].
	rmap sortVerticesByEnergy.
	rmap sortEdgesByEnergy.
	^ rmap
]

{ #category : #'*ReactionMapViewer-GRRMImport' }
RMapMorph class >> readDCs: aFileReference EQs: eqs [
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
]

{ #category : #'*ReactionMapViewer-GRRMImport' }
RMapMorph class >> readEQs: aFileReference [
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
]

{ #category : #'*ReactionMapViewer-GRRMImport' }
RMapMorph class >> readTSs: aFileReference EQs: eqs [
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
]
