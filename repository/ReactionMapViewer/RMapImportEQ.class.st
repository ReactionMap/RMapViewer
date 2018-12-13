Class {
	#name : #RMapImportEQ,
	#superclass : #RMapImportNode,
	#instVars : [
		'tss',
		'dcs',
		'gap'
	],
	#category : 'ReactionMapViewer-GRRMImport'
}

{ #category : #adding }
RMapImportEQ >> addDC: anRMapImportDC [
	^ dcs add: anRMapImportDC
]

{ #category : #adding }
RMapImportEQ >> addTS: anRMapImportTS [
	^ tss add: anRMapImportTS
]

{ #category : #layouting }
RMapImportEQ >> arrange: eqs [
	| bestScore bestEq |
	bestScore := 1.0e-5.
	bestEq := nil.
	eqs
		do: [ :eq | 
			| p score |
			p := position.
			score := (tss collect: #span) sum0 + (eq tss collect: #span) sum0.
			position := eq position.
			eq position: p.
			score := score - (tss collect: #span) sum0 - (eq tss collect: #span) sum0.
			eq position: position.
			position := p.
			score > bestScore
				ifTrue: [ 
					bestScore := score.
					bestEq := eq ] ].
	bestEq ifNil: [ ^ false ].
	bestEq == self
		ifTrue: [ ^ false ].
	self swap: bestEq.
	^ true
]

{ #category : #accessing }
RMapImportEQ >> dcs [
	^ dcs
]

{ #category : #accessing }
RMapImportEQ >> gap [
	^ gap
]

{ #category : #accessing }
RMapImportEQ >> gap: aNumber [
	gap := aNumber
]

{ #category : #'initialize-release' }
RMapImportEQ >> initialize [
	super initialize.
	tss := OrderedCollection new.
	dcs := OrderedCollection new
]

{ #category : #accessing }
RMapImportEQ >> originX [
	^ position x - (gap * 0.5)
]

{ #category : #accessing }
RMapImportEQ >> originY [
	^ position y - (gap * 0.5)
]

{ #category : #accessing }
RMapImportEQ >> rmapVertexClass [
	^ RMapEQVertex
]

{ #category : #layouting }
RMapImportEQ >> swap: eq [
	| p |
	p := position.
	position := eq position.
	eq position: p
]

{ #category : #accessing }
RMapImportEQ >> tss [
	^ tss
]
