private
multiframeIndex
	^ json
		at: 'multiframe_index'
		ifAbsent: [ 
			(json at: 'multiframe_xyz' ifAbsent: [  ])
				ifNil: [ 0 ]
				ifNotNil: [ :xyzs | 
					| mid |
					mid := RMapXYZFrame fromGeometry: self geometry.
					(xyzs findFirst: [ :xyz | (RMapXYZFrame fromXYZ: xyz) = mid ]) - 1 max: 0 ] ]