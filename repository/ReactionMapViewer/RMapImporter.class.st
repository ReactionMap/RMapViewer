Class {
	#name : #RMapImporter,
	#superclass : #Object,
	#instVars : [
		'ref',
		'prefix',
		'eqs',
		'tss',
		'dcs',
		'nodes'
	],
	#category : #'ReactionMapViewer-GRRMImport'
}

{ #category : #testing }
RMapImporter class >> isAbstract [

	^ self = RMapImporter
]

{ #category : #'instance creation' }
RMapImporter class >> on: aFileReference [

	^ self new setRef: aFileReference
]

{ #category : #arranging }
RMapImporter >> arrange [

	| eqsWithDummies numGrids gap |
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
	[
	| changed |
	changed := false.
	eqsWithDummies do: [ :eq |
		(eq arrange: eqsWithDummies) ifTrue: [ changed := true ] ].
	changed ] whileTrue.
	tss do: [ :ts | ts position: ts eq1 position + ts eq2 position * 0.5 ].
	dcs do: [ :dc | dc position: dc eq position ].
	tss do: [ :ts | ts arrange: nodes ].
	dcs do: [ :dc | dc arrange: nodes ].
	tss do: [ :ts | ts arrange: nodes ].
	dcs do: [ :dc | dc arrange: nodes ]
]

{ #category : #reading }
RMapImporter >> findPrefix [

	^ self subclassResponsibility
]

{ #category : #importing }
RMapImporter >> import [

	prefix := self findPrefix ifNil: [ ^ nil ].
	eqs := self readEQs.
	dcs := self readDCs.
	tss := self readTSs.
	nodes := eqs , dcs , tss.
	nodes ifEmpty: [ ^ nil ].
	self readBabel.
	self arrange
]

{ #category : #reading }
RMapImporter >> readBabel [
	^ 	UIManager default
		displayProgress: 'converting geometries with obabel...'
		from: 1
		to: nodes size
		during: [ :progress |
			nodes do: [ :node |
				node readBabel.
				progress increment ] ].

]

{ #category : #reading }
RMapImporter >> readComFile [

	ref / (prefix , '.com') ifExists: [ :comRef |
		comRef readStreamDo: [ :stream | ^ stream contents ] ].
	^ 'Not Available'
]

{ #category : #reading }
RMapImporter >> readDCs [

	^ self subclassResponsibility
]

{ #category : #reading }
RMapImporter >> readEQs [

	^ self subclassResponsibility
]

{ #category : #reading }
RMapImporter >> readTSs [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMapImporter >> rmap [

	| rmap |
	(eqs isNil or: [ tss isNil or: [ dcs isNil or: [ nodes isNil ] ] ])
		ifTrue: [ self import ].
	nodes ifNil: [ ^ nil ].
	nodes ifEmpty: [ ^ nil ].
	rmap := RMapMorph new.
	rmap extent: 500 @ 500.
	UIManager default
		displayProgress: 'reading molecules...'
		from: 1
		to: nodes size
		during: [ :progress |
			nodes do: [ :node |
				rmap addVertex: node asRMapVertex.
				progress increment ] ].
	dcs do: [ :dc |
		rmap addEdgeBetween: (nodes indexOf: dc) and: (nodes indexOf: dc eq) ].
	tss do: [ :ts |
		rmap
			addEdgeBetween: (nodes indexOf: ts)
			and: (nodes indexOf: ts eq1).
		rmap
			addEdgeBetween: (nodes indexOf: ts)
			and: (nodes indexOf: ts eq2) ].
	rmap grrm: self readComFile.
	rmap sortVerticesByEnergy.
	rmap sortEdgesByEnergy.
	rmap updateLayouter.
	^ rmap
]

{ #category : #private }
RMapImporter >> setRef: aFileReference [

	ref := aFileReference
]
