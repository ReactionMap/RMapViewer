Class {
	#name : #RMapDCVertex,
	#superclass : #RMapVertex,
	#category : 'ReactionMapViewer-Support'
}

{ #category : #private }
RMapDCVertex >> frameIndexFrom: vertex [
	^ (edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ (json at: 'multiframe_xyz' ifAbsent: [  ]) ifNil: [ 1 ] ifNotNil: [ :xyzs | xyzs size ] ]
		ifFalse: [ 1 ]
]

{ #category : #private }
RMapDCVertex >> frameIndexFrom: vertex1 to: vertex2 [
	^ ((edges contains: [ :edge | vertex1 == (edge oppositeOf: self) ])
		and: [ edges contains: [ :edge | vertex2 == (edge oppositeOf: self) ] ])
		ifTrue: [ (json at: 'multiframe_xyz' ifAbsent: [  ]) ifNil: [ 1 ] ifNotNil: [ :xyzs | xyzs size ] ]
		ifFalse: [ 1 ]
]

{ #category : #private }
RMapDCVertex >> frameIndexTo: vertex [
	^1
]

{ #category : #enumerating }
RMapDCVertex >> from: vertex energiesDo: aBlock [
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_energies' ifAbsent: [  ])
				ifNil: [ 
					aBlock value: self energy.
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ] ]
				ifNotNil: [ :energies | energies do: aBlock ] ]
		ifFalse: [ aBlock value: self energy ]
]

{ #category : #enumerating }
RMapDCVertex >> from: vertex framesDo: aBlock [
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
				ifNotNil: [ :xyzs | xyzs do: [ :xyz | aBlock value: (RMapXYZFrame fromXYZ: xyz) ] ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
]

{ #category : #enumerating }
RMapDCVertex >> from: vertex1 to: vertex2 energiesDo: aBlock [
	((edges contains: [ :edge | vertex1 == (edge oppositeOf: self) ])
		and: [ edges contains: [ :edge | vertex2 == (edge oppositeOf: self) ] ])
		ifTrue: [ 
			(json at: 'multiframe_energies' ifAbsent: [  ])
				ifNil: [ 
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ].
					aBlock value: self energy.
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ] ]
				ifNotNil: [ :energies | 
					energies do: aBlock.
					energies size - 1 to: 1 by: -1 do: [ :index | aBlock value: (energies at: index) ] ] ]
		ifFalse: [ aBlock value: self energy ]
]

{ #category : #enumerating }
RMapDCVertex >> from: vertex1 to: vertex2 framesDo: aBlock [
	((edges contains: [ :edge | vertex1 == (edge oppositeOf: self) ])
		and: [ edges contains: [ :edge | vertex2 == (edge oppositeOf: self) ] ])
		ifTrue: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
				ifNotNil: [ :xyzs | 
					xyzs do: [ :xyz | aBlock value: (RMapXYZFrame fromXYZ: xyz) ].
					xyzs size - 1 to: 1 by: -1 do: [ :index | aBlock value: (RMapXYZFrame fromXYZ: (xyzs at: index)) ] ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
]

{ #category : #testing }
RMapDCVertex >> isDC [
	^ true
]

{ #category : #accessing }
RMapDCVertex >> labelColor [
	^ Color white
]

{ #category : #enumerating }
RMapDCVertex >> to: vertex energiesDo: aBlock [
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_energies' ifAbsent: [  ])
				ifNil: [ 
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ].
					aBlock value: self energy ]
				ifNotNil: [ :energies | energies reverseDo: aBlock ] ]
		ifFalse: [ aBlock value: self energy ]
]

{ #category : #enumerating }
RMapDCVertex >> to: vertex framesDo: aBlock [
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
				ifNotNil: [ :xyzs | xyzs reverseDo: [ :xyz | aBlock value: (RMapXYZFrame fromXYZ: xyz) ] ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
]
