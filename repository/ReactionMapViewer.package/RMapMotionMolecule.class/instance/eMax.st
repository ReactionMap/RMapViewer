accessing
eMax
	^ moleculeGeometries ifEmpty: [ 0 ] ifNotEmpty: [ (moleculeGeometries collect: #energy) max ]