accessing
e0
	^ moleculeGeometries ifEmpty: [ 0 ] ifNotEmpty: [ moleculeGeometries first energy ]