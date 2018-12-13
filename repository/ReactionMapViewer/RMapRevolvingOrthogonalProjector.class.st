Class {
	#name : #RMapRevolvingOrthogonalProjector,
	#superclass : #RMapOrthogonalProjector,
	#instVars : [
		'r',
		'theta',
		'maxTheta'
	],
	#category : 'ReactionMapViewer-Projectors'
}

{ #category : #'initialize-release' }
RMapRevolvingOrthogonalProjector >> initialize [
	super initialize.
	r := 0.1.
	theta := 0.0.
	maxTheta := Float pi * 2.0
]

{ #category : #accessing }
RMapRevolvingOrthogonalProjector >> name [
	^ 'Rev 2D'
]

{ #category : #accessing }
RMapRevolvingOrthogonalProjector >> r [
	^ 0.002
]

{ #category : #stepping }
RMapRevolvingOrthogonalProjector >> step [
	theta := theta + 0.3.
	maxTheta <= theta ifTrue: [ theta := theta % maxTheta ]
]

{ #category : #accessing }
RMapRevolvingOrthogonalProjector >> value: anRMapVertex [
	^ (super value: anRMapVertex)
		ifNotNil: [ :p0 | 
			| dx dy |
			(self z: anRMapVertex)
				ifNotNil: [ :z | 
					dx := theta cos * rmap width * self r / (z + 0.1) / rmap viewScale.
					dy := theta sin * rmap width * self r / (z + 0.1) / rmap viewScale.
					(p0 x + dx) @ (p0 y + dy) ] ]
]

{ #category : #accessing }
RMapRevolvingOrthogonalProjector >> z: anRMapVertex [
	^ rmap zNumerizer value: anRMapVertex
]
