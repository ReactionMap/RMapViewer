private
frameIndexFrom: vertex1 to: vertex2
	^ ((edges contains: [ :edge | vertex1 == (edge oppositeOf: self) ])
		and: [ edges contains: [ :edge | vertex2 == (edge oppositeOf: self) ] ])
		ifTrue: [ (json at: 'multiframe_xyz' ifAbsent: [  ]) ifNil: [ 1 ] ifNotNil: [ :xyzs | xyzs size ] ]
		ifFalse: [ 1 ]