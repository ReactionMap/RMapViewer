functions
centerOfGravity
	| g |
	g := RMap3dPoint x: 0.0 y: 0.0 z: 0.0.
	self atomsDo: [ :atom :point |
		 g := g + point].
	^ g / atoms size