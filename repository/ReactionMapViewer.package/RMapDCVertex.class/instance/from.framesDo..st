enumerating
from: vertex framesDo: aBlock
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
				ifNotNil: [ :xyzs | xyzs do: [ :xyz | aBlock value: (RMapXYZFrame fromXYZ: xyz) ] ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]