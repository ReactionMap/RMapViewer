Class {
	#name : #RMapKind,
	#superclass : #RMapVertexNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapKind >> name [
	^ 'Kind'
]

{ #category : #accessing }
RMapKind >> value: anRMapVertex [
	| char |
	char := anRMapVertex label first.
	char = $E ifTrue: [  ^0.3 ].
	char = $T ifTrue: [  ^0.9 ].
	^ 0.1
]
