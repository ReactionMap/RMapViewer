Class {
	#name : #RMapGRRMDigestImporter,
	#superclass : #RMapGRRMImporter,
	#category : #'ReactionMapViewer-GRRMImport'
}

{ #category : #arranging }
RMapGRRMDigestImporter >> arrange [

	| eqsWithDummies numGrids maxIteration gap |
	numGrids := (eqs size sqrt ceiling + 0.5) asInteger.
	gap := 1.0 / numGrids.
	eqsWithDummies := (eqs , (Array
		                    new: numGrids * numGrids - eqs size
		                    streamContents: [ :stream |
			                    numGrids * numGrids - eqs size timesRepeat: [
				                    stream nextPut: RMapImportEQ new ] ])) shuffle.
	0 to: eqsWithDummies size - 1 do: [ :index |
		| eq x y |
		eq := eqsWithDummies at: index + 1.
		x := index \\ numGrids.
		y := index // numGrids.
		x odd ifTrue: [ y := y + 0.5 ].
		eq position: x + 0.5 * gap ,, (y + 0.5 * gap).
		eq gap: gap ].
	maxIteration := 10.
	UIManager default
		displayProgress: 'Layouting EQs'
		from: 1
		to: maxIteration
		during: [ :progress |
			[
			| changed |
			changed := false.
			eqsWithDummies do: [ :eq |
				(eq arrange: eqsWithDummies) ifTrue: [ changed := true ] ].
			progress increment.
			changed and: [ (maxIteration := maxIteration - 1) > 0 ] ] whileTrue ].
	tss do: [ :ts | ts position: ts eq1 position + ts eq2 position * 0.5 ].
	dcs do: [ :dc | dc position: dc eq position ].
	UIManager default
		displayProgress: 'Layouting TSs and DCs'
		from: 1
		to: tss size + dcs size * 2
		during: [ :progress |
			tss do: [ :ts |
				ts arrange: nodes.
				progress increment ].
			dcs do: [ :dc |
				dc arrange: nodes.
				progress increment ].
			tss do: [ :ts |
				ts arrange: nodes.
				progress increment ].
			dcs do: [ :dc |
				dc arrange: nodes.
				progress increment ] ]
]

{ #category : #reading }
RMapGRRMDigestImporter >> readBabel [

	
]

{ #category : #reading }
RMapGRRMDigestImporter >> readDCs [

	^ Array new
]
