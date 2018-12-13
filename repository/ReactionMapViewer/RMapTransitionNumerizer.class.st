Class {
	#name : #RMapTransitionNumerizer,
	#superclass : #RMapVertexNumerizer,
	#instVars : [
		'from',
		'to',
		'steps',
		'maxSteps'
	],
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #'instance creation' }
RMapTransitionNumerizer class >> on: anRMapMorph from: anRMapVertexNumerizer1 to: anRMapVertexNumerizer2 setter: aSymbol [
	^ (self on: anRMapMorph setter: aSymbol)
		from: anRMapVertexNumerizer1 to: anRMapVertexNumerizer2;
		yourself
]

{ #category : #private }
RMapTransitionNumerizer >> from: anRMapVertexNumerizer1 to: anRMapVertexNumerizer2 [
	from := anRMapVertexNumerizer1.
	to := anRMapVertexNumerizer2
]

{ #category : #'initialize-release' }
RMapTransitionNumerizer >> initialize [
	super initialize.
	steps := 0.
	maxSteps := 10
]

{ #category : #accessing }
RMapTransitionNumerizer >> name [
	^ from name, '->', to name
]

{ #category : #accessing }
RMapTransitionNumerizer >> reset [
	steps := 0
]

{ #category : #stepping }
RMapTransitionNumerizer >> step [
	steps := steps + 1.
	steps > maxSteps
		ifTrue: [ rmap perform: setter with: to ]
]

{ #category : #accessing }
RMapTransitionNumerizer >> update [
	from update.
	to update
]

{ #category : #accessing }
RMapTransitionNumerizer >> value: anRMapVertex [
	^ self subclassResponsibility 
]
