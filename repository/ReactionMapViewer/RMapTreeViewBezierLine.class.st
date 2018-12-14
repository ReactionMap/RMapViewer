Class {
	#name : #RMapTreeViewBezierLine,
	#superclass : #RTBezierLine,
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'control points' }
RMapTreeViewBezierLine >> getListOfPointsForTrachel: anEdge [
	| tip listOfPoints start end centerX |
	tip := 20.
	listOfPoints := OrderedCollection new.
	start := attachPoint startingPointOf: anEdge.
	end := attachPoint endingPointOf: anEdge.
	centerX := (start x - end x) abs < 5.0
		ifTrue: [ start x - tip ]
		ifFalse: [ (start x + end x) // 2 ].
	listOfPoints add: start.
	listOfPoints add: start x @ (start y + tip).
	listOfPoints add: centerX @ (start y + tip).
	listOfPoints add: centerX @ (end y - tip).
	listOfPoints add: end x @ (end y - tip).
	listOfPoints add: end.
	^ listOfPoints
]

{ #category : #hooks }
RMapTreeViewBezierLine >> trachelShapeClass [
	^ TRBezierShape
]
