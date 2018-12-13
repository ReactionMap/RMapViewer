Class {
	#name : #RMapEdge,
	#superclass : #Object,
	#instVars : [
		'vertex1',
		'vertex2'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapEdge class >> between: anRMapVertexMorph1 and: anRMapVertexMorph2 [ 
	^ self new setVertex1: anRMapVertexMorph1 vertex2: anRMapVertexMorph2;
		 yourself
]

{ #category : #testing }
RMapEdge >> hasVertex: anRMapVertex [
	^ vertex1 == anRMapVertex or: [vertex2 == anRMapVertex]
]

{ #category : #accessing }
RMapEdge >> oppositeOf: vertex [
	vertex1 == vertex
		ifTrue: [ ^ vertex2 ].
	vertex2 == vertex
		ifTrue: [ ^ vertex1 ].
	^ nil
]

{ #category : #printing }
RMapEdge >> printOn: aStream [
	aStream nextPut: $<.
	vertex1 ifNotNil: [ vertex1 label ifNotNil: [ aStream nextPutAll: vertex1 label ] ].
	aStream nextPut: $-.
	vertex2 ifNotNil: [ vertex2 label ifNotNil: [ aStream nextPutAll: vertex2 label ] ].
	aStream nextPut: $>.

]

{ #category : #private }
RMapEdge >> setVertex1: anRMapVertex1 vertex2: anRMapVertex2 [
	vertex1 := anRMapVertex1.
	vertex2 := anRMapVertex2.
	anRMapVertex1 addEdge: self.
	anRMapVertex2 addEdge: self.
]

{ #category : #accessing }
RMapEdge >> vertex1 [
	^ vertex1
]

{ #category : #accessing }
RMapEdge >> vertex2 [
	^ vertex2
]
