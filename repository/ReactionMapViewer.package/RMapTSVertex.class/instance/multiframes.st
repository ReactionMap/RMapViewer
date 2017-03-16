private
multiframes
	^ (json at: 'multiframe_xyz' ifAbsent: [  ])
		ifNil: [ Array with: (RMapXYZFrame fromGeometry: self geometry) ]
		ifNotNil: [ :xyzs | xyzs collect: [ :xyz | RMapXYZFrame fromXYZ: xyz ] ]