Class {
	#name : #RMapFlippedRevolvingOrthogonalProjector,
	#superclass : #RMapRevolvingOrthogonalProjector,
	#category : 'ReactionMapViewer-Projectors'
}

{ #category : #accessing }
RMapFlippedRevolvingOrthogonalProjector >> name [
	^ 'flipped Rev 2D'
]

{ #category : #accessing }
RMapFlippedRevolvingOrthogonalProjector >> z: aNumber [
	^ (super z: aNumber) ifNotNil: [  :z | 1.0 - z ]
]
