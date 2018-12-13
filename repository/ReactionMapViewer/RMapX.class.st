Class {
	#name : #RMapX,
	#superclass : #RMapVertexNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapX >> name [
	^ 'map X'
]

{ #category : #accessing }
RMapX >> value: anRMapVertex [
	^ anRMapVertex position x
]
