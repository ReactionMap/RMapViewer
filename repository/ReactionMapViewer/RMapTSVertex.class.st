Class {
	#name : #RMapTSVertex,
	#superclass : #RMapVertex,
	#category : 'ReactionMapViewer-Support'
}

{ #category : #enumerating }
RMapTSVertex >> frameIndexFrom: vertex [
	^ (edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ 1 ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ 1 ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ 1 ]
						ifNotNil: [ :vertex2 | 
							vertex label <= vertex2 label
								ifTrue: [ self multiframeIndex + 1 ]
								ifFalse: [ self multiframes size - self multiframeIndex ] ] ] ]
]

{ #category : #enumerating }
RMapTSVertex >> frameIndexFrom: vertex1 to: vertex2 [
	^ ((edges contains: [ :edge | (edge oppositeOf: self) == vertex1 ])
		and: [ edges contains: [ :edge | (edge oppositeOf: self) == vertex2 ] ])
		ifTrue: [ 
			vertex1 label <= vertex2 label
				ifTrue: [ self multiframeIndex + 1 ]
				ifFalse: [ self multiframes size - self multiframeIndex ] ]
		ifFalse: [ 1 ]
]

{ #category : #enumerating }
RMapTSVertex >> frameIndexTo: vertex [
	^ 1
]

{ #category : #enumerating }
RMapTSVertex >> from: vertex energiesDo: aBlock [
	(edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ aBlock value: self energy ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ aBlock value: self energy ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ aBlock value: self energy ]
						ifNotNil: [ :vertex2 | 
							| energies |
							energies := self multiframeEnergies.
							(vertex label <= vertex2 label
								ifTrue: [ 1 to: (self multiframeIndex + 1 min: energies size) ]
								ifFalse: [ energies size to: self multiframeIndex + 1 by: -1 ]) do: [ :index | aBlock value: (energies at: index) ] ] ] ]
]

{ #category : #enumerating }
RMapTSVertex >> from: vertex framesDo: aBlock [
	(edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ aBlock value: self energy ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ aBlock value: self energy ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ aBlock value: self energy ]
						ifNotNil: [ :vertex2 | 
							| frames |
							frames := self multiframes.
							(vertex label <= vertex2 label
								ifTrue: [ 1 to: (self multiframeIndex + 1 min: frames size) ]
								ifFalse: [ frames size to: self multiframeIndex + 1 by: -1 ]) do: [ :index | aBlock value: (frames at: index) ] ] ] ]
]

{ #category : #enumerating }
RMapTSVertex >> from: vertex1 to: vertex2 energiesDo: aBlock [
	((edges contains: [ :edge | (edge oppositeOf: self) == vertex1 ])
		and: [ edges contains: [ :edge | (edge oppositeOf: self) == vertex2 ] ])
		ifTrue: [ 
			vertex1 label <= vertex2 label
				ifTrue: [ self multiframeEnergies do: aBlock ]
				ifFalse: [ self multiframeEnergies reverseDo: aBlock ] ]
		ifFalse: [ aBlock value: self energy ]
]

{ #category : #enumerating }
RMapTSVertex >> from: vertex1 to: vertex2 framesDo: aBlock [
	((edges contains: [ :edge | (edge oppositeOf: self) == vertex1 ])
		and: [ edges contains: [ :edge | (edge oppositeOf: self) == vertex2 ] ])
		ifTrue: [ 
			vertex1 label <= vertex2 label
				ifTrue: [ self multiframes do: aBlock ]
				ifFalse: [ self multiframes reverseDo: aBlock ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
]

{ #category : #testing }
RMapTSVertex >> isTS [
	^ true
]

{ #category : #private }
RMapTSVertex >> multiframeEnergies [
	^ json
		at: 'multiframe_energies'
		ifAbsent: [ 
			(Array new: self multiframes size)
				at: self multiframeIndex + 1 put: self energy;
				yourself ]
]

{ #category : #private }
RMapTSVertex >> multiframeIndex [
	^ json
		at: 'multiframe_index'
		ifAbsent: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ 0 ]
				ifNotNil: [ :xyzs | 
					| mid |
					mid := RMapXYZFrame fromGeometry: self geometry.
					(xyzs findFirst: [ :xyz | (RMapXYZFrame fromXYZ: xyz) = mid ]) - 1 max: 0 ] ]
]

{ #category : #private }
RMapTSVertex >> multiframes [
	^ (json at: 'multiframe_xyz' ifAbsent: [  ])
		ifNil: [ Array with: (RMapXYZFrame fromGeometry: self geometry) ]
		ifNotNil: [ :xyzs | xyzs collect: [ :xyz | RMapXYZFrame fromXYZ: xyz ] ]
]

{ #category : #enumerating }
RMapTSVertex >> to: vertex energiesDo: aBlock [
	(edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ aBlock value: self energy ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ aBlock value: self energy ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ aBlock value: self energy ]
						ifNotNil: [ :vertex2 | 
							| energies |
							energies := self multiframeEnergies.
							(vertex2 label <= vertex label
								ifTrue: [ self multiframeIndex + 1 to: energies size ]
								ifFalse: [ (self multiframeIndex + 1 min: energies size) to: 1 by: -1 ]) do: [ :index | aBlock value: (energies at: index) ] ] ] ]
]

{ #category : #enumerating }
RMapTSVertex >> to: vertex framesDo: aBlock [
	(edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ aBlock value: self energy ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ aBlock value: self energy ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ aBlock value: self energy ]
						ifNotNil: [ :vertex2 | 
							| frames |
							frames := self multiframes.
							(vertex2 label <= vertex label
								ifTrue: [ self multiframeIndex + 1 to: frames size ]
								ifFalse: [ (self multiframeIndex + 1 min: frames size) to: 1 by: -1 ]) do: [ :index | aBlock value: (frames at: index) ] ] ] ]
]
