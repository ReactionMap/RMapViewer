*ReactionMapViewer-GRRMImport
fromDirectory: aFileReference
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