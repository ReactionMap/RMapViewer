Class {
	#name : #RMapRevolvingTransitionNumerizer,
	#superclass : #RMapTransitionNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapRevolvingTransitionNumerizer >> value: anRMapVertex [
	| theta fromValue toValue |
	theta := steps asFloat * Float pi / 2.0 / maxSteps asFloat.
	fromValue := from value: anRMapVertex.
	fromValue ifNil: [ ^ nil ].
	toValue := to value: anRMapVertex.
	toValue ifNil: [ ^ nil ].
	^ ((fromValue * 2.0 - 1.0) * theta cos + ((toValue * 2.0 - 1.0) * theta sin) + 1.0) / 2.0
]
