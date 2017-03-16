private
frameIndexFrom: vertex
	^ (edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ (json at: 'multiframe_xyz' ifAbsent: [  ]) ifNil: [ 1 ] ifNotNil: [ :xyzs | xyzs size ] ]
		ifFalse: [ 1 ]