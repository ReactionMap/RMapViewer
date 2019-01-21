Class {
	#name : #RMapNullRenderer,
	#superclass : #RMapRenderer,
	#category : 'ReactionMapViewer-Renderers'
}

{ #category : #'accessing-edge points' }
RMapNullRenderer >> centerEdgePointsFor: anRMapVertex do: aBlock [
]

{ #category : #drawing }
RMapNullRenderer >> drawEdge: anRMapEdge color: aColor on: aCanvas [
]

{ #category : #drawing }
RMapNullRenderer >> drawVertex: anRMapVertex borderColor: aColor on: aCanvas [
	^ nil
]

{ #category : #'accessing-edge points' }
RMapNullRenderer >> edgePointsBetween: anRMapVertex1 and: anRMapVertex2 do: aBlock [
]

{ #category : #'accessing-edge points' }
RMapNullRenderer >> edgePointsFor: anRMapVertex do: aBlock [
]

{ #category : #'accessing-forms' }
RMapNullRenderer >> formsFor: anRMapVertex [
	^ nil
]

{ #category : #'accessing-edge points' }
RMapNullRenderer >> leftAndRightEdgePointsFor: anRMapVertex do: aBlock [
]

{ #category : #accessing }
RMapNullRenderer >> name [
	^ 'null'
]
