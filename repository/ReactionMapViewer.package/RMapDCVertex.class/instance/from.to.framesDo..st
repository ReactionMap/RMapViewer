enumerating
from: vertex1 to: vertex2 framesDo: aBlock
	((edges contains: [ :edge | vertex1 == (edge oppositeOf: self) ])
		and: [ edges contains: [ :edge | vertex2 == (edge oppositeOf: self) ] ])
		ifTrue: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]
				ifNotNil: [ :xyzs | 
					xyzs do: [ :xyz | aBlock value: (RMapXYZFrame fromXYZ: xyz) ].
					xyzs size - 1 to: 1 by: -1 do: [ :index | aBlock value: (RMapXYZFrame fromXYZ: (xyzs at: index)) ] ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]