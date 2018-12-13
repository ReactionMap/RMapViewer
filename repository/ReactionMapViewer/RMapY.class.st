Class {
	#name : #RMapY,
	#superclass : #RMapVertexNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapY >> name [
	^ 'map Y'
]

{ #category : #accessing }
RMapY >> value: anRMapVertex [
	^ anRMapVertex position y
]
