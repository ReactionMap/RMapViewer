Class {
	#name : #RMapInterval,
	#superclass : #Object,
	#instVars : [
		'min',
		'max'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMapInterval class >> empty [
	^ self from: Float fmax to: Float fmax negated
]

{ #category : #'instance creation' }
RMapInterval class >> from: aNumber1 to: aNumber2 [
	^ self new
		setMin: aNumber1 max: aNumber2;
		yourself
]

{ #category : #'instance creation' }
RMapInterval class >> total [
	^ self from: Float fmax negated to: Float fmax
]

{ #category : #testing }
RMapInterval >> includes: aNumber [
	^ aNumber between: min and: max
]

{ #category : #accessing }
RMapInterval >> max [
	^ max
]

{ #category : #accessing }
RMapInterval >> max: aNumber [
	max := aNumber
]

{ #category : #adding }
RMapInterval >> merge: aNumber [
	min := min min: aNumber.
	max := max max: aNumber
]

{ #category : #accessing }
RMapInterval >> min [
	^ min
]

{ #category : #accessing }
RMapInterval >> min: aNumber [
	min := aNumber
]

{ #category : #private }
RMapInterval >> setMin: aNumber1 max: aNumber2 [
	min := aNumber1.
	max := aNumber2
]
