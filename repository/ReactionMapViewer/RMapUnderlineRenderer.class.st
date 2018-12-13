Class {
	#name : #RMapUnderlineRenderer,
	#superclass : #RMapRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #accessing }
RMapUnderlineRenderer >> edgePointsFor: anRMapVertex do: aBlock [
	self leftAndRightEdgePointsFor: anRMapVertex do: aBlock
]

{ #category : #accessing }
RMapUnderlineRenderer >> formsFor: anRMapVertex [
	^ self underlineLabelFormsFor: anRMapVertex
]

{ #category : #accessing }
RMapUnderlineRenderer >> name [
	^'underline'
]
