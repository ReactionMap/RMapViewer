Class {
	#name : #RMapLinearTransitionNumerizer,
	#superclass : #RMapTransitionNumerizer,
	#category : 'ReactionMapViewer-Numerizers'
}

{ #category : #accessing }
RMapLinearTransitionNumerizer >> value: anRMapVertex [
	| gamma fromValue toValue |
	gamma := steps asFloat / maxSteps asFloat.
	fromValue := from value: anRMapVertex.
	fromValue ifNil: [ ^ nil ].
	toValue := to value: anRMapVertex.
	toValue ifNil: [ ^ nil ].
	^ (1.0 - gamma) * fromValue + (gamma * toValue)
]
