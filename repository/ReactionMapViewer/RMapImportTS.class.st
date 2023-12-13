Class {
	#name : #RMapImportTS,
	#superclass : #RMapImportNode,
	#instVars : [
		'eq1',
		'eq2',
		'multiframeXYZ',
		'multiframeEnergies',
		'multiframeIndex'
	],
	#category : #'ReactionMapViewer-GRRMImport'
}

{ #category : #layouting }
RMapImportTS >> arrange: nodes [
	| scoreBlock bestPosition bestScore x0 y0 dx dy |
	scoreBlock := [ 
	(nodes
		collect: [ :n | 
			n == self
				ifTrue: [ Float fmax ]
				ifFalse: [ n position dist: position ] ]) min ].
	bestPosition := position.
	bestScore := scoreBlock value.
	x0 := eq1 position x min: eq2 position x.
	y0 := eq1 position y min: eq2 position y.
	dx := (eq1 position x max: eq2 position x) - x0 + eq1 gap.
	dy := (eq1 position y max: eq2 position y) - y0 + eq1 gap.
	x0 := x0 - (eq1 gap * 0.5).
	y0 := y0 - (eq1 gap * 0.5).
	50
		timesRepeat: [ 
			| score |
			position := dx * self random + x0 ,, (dy * self random + y0).
			score := scoreBlock value.
			score > bestScore
				ifTrue: [ 
					bestScore := score.
					bestPosition := position ] ].
	position := bestPosition
]

{ #category : #accessing }
RMapImportTS >> createSoleMultiframe [

	multiframeXYZ := { self xyz }.
	multiframeEnergies := { energy }.
	multiframeIndex := 1
]

{ #category : #accessing }
RMapImportTS >> eq1 [
	^ eq1
]

{ #category : #accessing }
RMapImportTS >> eq1: anRMapImportEQ [
	eq1 := anRMapImportEQ.
	anRMapImportEQ addTS: self
]

{ #category : #accessing }
RMapImportTS >> eq2 [
	^ eq2
]

{ #category : #accessing }
RMapImportTS >> eq2: anRMapImportEQ [
	eq2 := anRMapImportEQ.
	anRMapImportEQ addTS: self
]

{ #category : #'initialize-release' }
RMapImportTS >> initialize [
	super initialize.
	multiframeXYZ := Array new.
	multiframeEnergies := Array new.
	multiframeIndex := 0
]

{ #category : #testing }
RMapImportTS >> isValid [

	^ eq1 notNil and: [ eq2 notNil ]
]

{ #category : #accessing }
RMapImportTS >> json [
	^ super json
		at: 'multiframe_xyz' put: multiframeXYZ;
		at: 'multiframe_energies' put: multiframeEnergies;
		at: 'multiframe_index' put: multiframeIndex;
		yourself
]

{ #category : #accessing }
RMapImportTS >> peer: eq [
	^ eq == eq1
		ifTrue: [ eq2 ]
		ifFalse: [ eq1 ]
]

{ #category : #accessing }
RMapImportTS >> readMultiframe: aStream [
	| chunks header forwardSteps backwardSteps forwardXYZ forwardEnergies backwardXYZ backwardEnergies geom |
	chunks := '=========================================================================' split: aStream contents.
	header := geometry size printString , String lf , String lf.
	forwardSteps := (String lf , String lf split: chunks second) select: [ :step | '# STEP *' match: step ].
	forwardXYZ := forwardSteps
		collect: [ :step | header , (String lf join: (String lf , 'ENERGY' split: step) first lines copyWithoutFirst) ].
	forwardEnergies := forwardSteps collect: [ :step | ($= split: step lines reverse second) second trim asNumber asFloat ].
	backwardSteps := (String lf , String lf split: chunks fourth) select: [ :step | '# STEP *' match: step ].
	backwardXYZ := backwardSteps
		collect: [ :step | header , (String lf join: (String lf , 'ENERGY' split: step) first lines copyWithoutFirst) ].
	backwardEnergies := backwardSteps
		collect: [ :step | ($= split: step lines reverse second) second trim asNumber asFloat ].
	geom := header
		, (String lf join: (String lf , 'ENERGY' split: chunks first) first lines copyWithoutFirst copyWithoutFirst).
	eq1 label <= eq2 label
		ifTrue: [ 
			multiframeXYZ := forwardXYZ reversed , {geom} , backwardXYZ.
			multiframeEnergies := forwardEnergies reversed , {energy} , backwardEnergies.
			multiframeIndex := forwardXYZ size ]
		ifFalse: [ 
			multiframeXYZ := backwardXYZ reversed , {geom} , forwardXYZ.
			multiframeEnergies := backwardEnergies reversed , {energy} , forwardEnergies.
			multiframeIndex := backwardXYZ size ]
]

{ #category : #accessing }
RMapImportTS >> rmapVertexClass [
	^ RMapTSVertex
]

{ #category : #accessing }
RMapImportTS >> span [
	^ eq1 dist: eq2
]
