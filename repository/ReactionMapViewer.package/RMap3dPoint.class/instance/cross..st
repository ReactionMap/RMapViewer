point functions
cross: anRMap3dPoint
	| x1 y1 z1 |
	x1 := anRMap3dPoint x.
	y1 := anRMap3dPoint y.
	z1 := anRMap3dPoint z.
	^ self class x: y * z1 - (z * y1) y: z * x1 - (x * z1) z: x * y1 - (y * x1)