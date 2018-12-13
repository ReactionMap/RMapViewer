Class {
	#name : #RMapRevolvingPerspectiveProjector,
	#superclass : #RMapPerspectiveProjector,
	#instVars : [
		'r',
		'theta',
		'maxTheta'
	],
	#category : 'ReactionMapViewer-Projectors'
}

{ #category : #'initialize-release' }
RMapRevolvingPerspectiveProjector >> initialize [
	super initialize.
	r := 0.1.
	theta := 0.0.
	maxTheta := Float pi * 2.0
]

{ #category : #accessing }
RMapRevolvingPerspectiveProjector >> name [
	^ 'Rev 3D'
]

{ #category : #accessing }
RMapRevolvingPerspectiveProjector >> r [
	^ r
]

{ #category : #stepping }
RMapRevolvingPerspectiveProjector >> step [
	theta := theta + 0.2.
	maxTheta <= theta ifTrue: [ theta := theta % maxTheta ]
]

{ #category : #accessing }
RMapRevolvingPerspectiveProjector >> value: anRMapVertex [
	| z dx dy w h scale x y |
	z := rmap zNumerizer value: anRMapVertex.
	z ifNil: [ ^ nil ].
	z := z + 1.0.
	r := self r.
	dx := theta cos * r / rmap viewScale.
	dy := theta sin * r / rmap viewScale.
	w := rmap width asFloat.
	h := rmap height asFloat.
	scale := w max: h.
	x := rmap xNumerizer value: anRMapVertex.
	x ifNil: [ ^ nil ].
	x := (x - rmap viewOffset x + dx) / z * rmap viewScale * scale + (w // 2).
	y := rmap yNumerizer value: anRMapVertex.
	y ifNil: [ ^ nil ].
	y := (y - rmap viewOffset y + dy) / z * rmap viewScale negated * scale + (h // 2).
	^ x @ y
]
