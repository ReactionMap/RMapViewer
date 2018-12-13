Class {
	#name : #RMap3dPoint,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : 'ReactionMapViewer-Support'
}

{ #category : #'instance creation' }
RMap3dPoint class >> x: x y: y z: z [
	^ self new
		setX: x y: y z: z;
		yourself
]

{ #category : #arithmetics }
RMap3dPoint >> * aNumber [
	^ self scaled: aNumber
]

{ #category : #arithmetics }
RMap3dPoint >> + anRMap3dPoint [
	^ self class x: x + anRMap3dPoint x y: y + anRMap3dPoint y z: z + anRMap3dPoint z
]

{ #category : #arithmetics }
RMap3dPoint >> - anRMap3dPoint [
	^ self class x: x - anRMap3dPoint x y: y - anRMap3dPoint y z: z - anRMap3dPoint z
]

{ #category : #'point functions' }
RMap3dPoint >> / aNumber [
	^ self class x: x / aNumber y: y / aNumber z: z / aNumber
]

{ #category : #'point functions' }
RMap3dPoint >> cross: anRMap3dPoint [
	| x1 y1 z1 |
	x1 := anRMap3dPoint x.
	y1 := anRMap3dPoint y.
	z1 := anRMap3dPoint z.
	^ self class x: y * z1 - (z * y1) y: z * x1 - (x * z1) z: x * y1 - (y * x1)
]

{ #category : #'point functions' }
RMap3dPoint >> dist: anRMap3dPoint [
	^ (self squaredDist: anRMap3dPoint) sqrt
]

{ #category : #'point functions' }
RMap3dPoint >> dot: anRMap3dPoint [
	^ x * anRMap3dPoint x + (y * anRMap3dPoint y) + (z * anRMap3dPoint z)
]

{ #category : #accessing }
RMap3dPoint >> r [
	^ (x squared + y squared + z squared) sqrt
]

{ #category : #'point functions' }
RMap3dPoint >> scaled: aNumber [
	^ self class x: x * aNumber y: y * aNumber z: z * aNumber
]

{ #category : #private }
RMap3dPoint >> setX: aNumber1 y: aNumber2 z: aNumber3 [
	x := aNumber1 asFloat.
	y := aNumber2 asFloat.
	z := aNumber3 asFloat
]

{ #category : #'point functions' }
RMap3dPoint >> squaredDist: anRMap3dPoint [
	^ (x - anRMap3dPoint x) squared + (y - anRMap3dPoint y) squared + (z - anRMap3dPoint z) squared
]

{ #category : #'point functions' }
RMap3dPoint >> unit [
	| r |
	r := self r.
	^ self class x: x / r y: y / r z: z / r
]

{ #category : #accessing }
RMap3dPoint >> x [
	^x
]

{ #category : #accessing }
RMap3dPoint >> y [
	^y
]

{ #category : #accessing }
RMap3dPoint >> z [
	^z
]
