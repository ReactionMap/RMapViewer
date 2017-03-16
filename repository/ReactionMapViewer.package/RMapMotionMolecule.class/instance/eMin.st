accessing
eMin
	^ moleculeGeometries ifEmpty: [ 0 ] ifNotEmpty: [ (moleculeGeometries collect: #energy) min ]