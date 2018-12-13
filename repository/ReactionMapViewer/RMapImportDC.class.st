Class {
	#name : #RMapImportDC,
	#superclass : #RMapImportNode,
	#instVars : [
		'eq',
		'multiframeXYZ',
		'multiframeEnergies'
	],
	#category : 'ReactionMapViewer-GRRMImport'
}

{ #category : #layouting }
RMapImportDC >> arrange: nodes [
	| scoreBlock bestPosition bestScore x0 y0 gap |
	scoreBlock := [ 
	(nodes
		collect: [ :n | 
			n == self
				ifTrue: [ Float fmax ]
				ifFalse: [ n position dist: position ] ]) min ].
	bestPosition := position.
	bestScore := scoreBlock value.
	x0 := eq position x - (eq gap * 0.5).
	y0 := eq position y - (eq gap * 0.5).
	gap := eq gap.
	50
		timesRepeat: [ 
			| score |
			position := gap * self random + x0 ,, (gap * self random + y0).
			score := scoreBlock value.
			score > bestScore
				ifTrue: [ 
					bestScore := score.
					bestPosition := position ] ].
	position := bestPosition
]

{ #category : #accessing }
RMapImportDC >> eq [
	^ eq
]

{ #category : #accessing }
RMapImportDC >> eq: anRMapImportEQ [
	eq := anRMapImportEQ.
	anRMapImportEQ addDC: self
]

{ #category : #'initialize-release' }
RMapImportDC >> initialize [
	super initialize.
	multiframeXYZ := Array new.
	multiframeEnergies := Array new
]

{ #category : #accessing }
RMapImportDC >> json [
	^ super json
		at: 'multiframe_xyz' put: multiframeXYZ;
		at: 'multiframe_energies' put: multiframeEnergies;
		yourself
]

{ #category : #accessing }
RMapImportDC >> readMultiframe: aStream [
	| chunks header steps forwardXYZ forwardEnergies geom |
	chunks := '=========================================================================' split: aStream contents.
	header := geometry size printString , String lf , String lf.
	steps := (String lf , String lf split: chunks second) select: [ :step | '# STEP *' match: step ].
	forwardXYZ := steps
		collect: [ :step | header , (String lf join: (String lf , 'ENERGY' split: step) first lines copyWithoutFirst) ].
	forwardEnergies := steps collect: [ :step | ($= split: step lines reverse second) second trim asNumber asFloat ].
	geom := header
		, (String lf join: (String lf , 'ENERGY' split: chunks first) first lines copyWithoutFirst copyWithoutFirst).
	multiframeXYZ := forwardXYZ reversed copyWith: geom.
	multiframeEnergies := forwardEnergies reversed copyWith: energy
]

{ #category : #accessing }
RMapImportDC >> rmapVertexClass [
	^ RMapDCVertex
]
