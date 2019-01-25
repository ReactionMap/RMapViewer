Class {
	#name : #RMapEQVertex,
	#superclass : #RMapVertex,
	#category : 'ReactionMapViewer-Support'
}

{ #category : #private }
RMapEQVertex >> frameIndexFrom: vertex [
	^ 1
]

{ #category : #private }
RMapEQVertex >> frameIndexFrom: vertex1 to: vertex2 [
	^ 1
]

{ #category : #private }
RMapEQVertex >> frameIndexTo: vertex [
	^ 1
]

{ #category : #enumerating }
RMapEQVertex >> from: vertex energiesDo: aBlock [
	aBlock value: self energy
]

{ #category : #enumerating }
RMapEQVertex >> from: vertex framesDo: aBlock [
	aBlock value: (RMapXYZFrame fromGeometry: self geometry)
]

{ #category : #enumerating }
RMapEQVertex >> from: vertex1 to: vertex2 energiesDo: aBlock [
	aBlock value: self energy
]

{ #category : #enumerating }
RMapEQVertex >> from: vertex1 to: vertex2 framesDo: aBlock [
	aBlock value: (RMapXYZFrame fromGeometry: self geometry)
]

{ #category : #testing }
RMapEQVertex >> isEQ [
	^ true
]

{ #category : #accessing }
RMapEQVertex >> labelColor [
	^ Color lightGray
]

{ #category : #enumerating }
RMapEQVertex >> to: vertex energiesDo: aBlock [
	aBlock value: self energy
]

{ #category : #enumerating }
RMapEQVertex >> to: vertex framesDo: aBlock [
	aBlock value: (RMapXYZFrame fromGeometry: self geometry)
]
