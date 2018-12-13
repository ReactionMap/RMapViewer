Class {
	#name : #RMapVertexNumerizer,
	#superclass : #Object,
	#instVars : [
		'rmap',
		'setter'
	],
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #'instance creation' }
RMapVertexNumerizer class >> on: anRMapMorph setter: aSymbol [
	^ self new
		rmap: anRMapMorph;
		setter: aSymbol;
		yourself
]

{ #category : #accessing }
RMapVertexNumerizer >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
RMapVertexNumerizer >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
RMapVertexNumerizer >> reset [
	"do nothing by default"
]

{ #category : #accessing }
RMapVertexNumerizer >> rmap [
	^ rmap
]

{ #category : #accessing }
RMapVertexNumerizer >> rmap: anRMapMorph [
	rmap := anRMapMorph
]

{ #category : #accessing }
RMapVertexNumerizer >> setter [
	^ setter
]

{ #category : #accessing }
RMapVertexNumerizer >> setter: aSymbol [
	setter := aSymbol
]

{ #category : #stepping }
RMapVertexNumerizer >> step [
	"do nothing by default"
]

{ #category : #accessing }
RMapVertexNumerizer >> transitionLinearTo: anRMapVertexNumerizer [
	anRMapVertexNumerizer reset.
	rmap
		perform: setter
		with:
			(RMapLinearTransitionNumerizer
				on: rmap
				from: self
				to: anRMapVertexNumerizer
				setter: setter)
]

{ #category : #accessing }
RMapVertexNumerizer >> transitionRevolvingTo: anRMapVertexNumerizer [
	anRMapVertexNumerizer reset.
	rmap
		perform: setter
		with:
			(RMapRevolvingTransitionNumerizer
				on: rmap
				from: self
				to: anRMapVertexNumerizer
				setter: setter)
]

{ #category : #accessing }
RMapVertexNumerizer >> transitionTo: anRMapVertexNumerizer [
	^self transitionRevolvingTo: anRMapVertexNumerizer 
]

{ #category : #accessing }
RMapVertexNumerizer >> update [
	"do nothing by default."
]

{ #category : #accessing }
RMapVertexNumerizer >> updateSelection [
	
]

{ #category : #accessing }
RMapVertexNumerizer >> value: anRMapVertex [ 
	^ self subclassResponsibility
]
