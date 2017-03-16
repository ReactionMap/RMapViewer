converting
asFormExtent: aPoint
	| molecule box center form projection rc |
	molecule := RMapMolecule new.
	self geometry2dDo: [:atom :x :y :z |
		molecule add: (JunAtom symbol: atom at: (Jun3dPoint x: x y: y z: z)) ].
	molecule autoBonds.
	box := molecule boundingBox.
	center := box center.
	form := Form extent: aPoint depth: 32.
	projection := JunParallelProjection
		eyePoint: 0, 0, (box depth * 2) + center
		sightPoint: center
		upVector: 0 , 1 , 0
		height: (box width max: box height)
		near: 0.1
		far: box depth * 10.
	[ 
	rc := [ form renderingContext ]
		on: Error
		do: [ :ex | nil ].
	rc isNil ] whileTrue: [ Processor yield ].
	rc enableCullface.
	rc backgroundColor: Color transparent.
	rc projection: projection.
	rc clear.
	rc ambientLight: Color gray.
	rc lightIndex: 0 parallel: projection eyePoint negated color: Color gray.
	molecule renderOn: rc.
	rc flush.
	^ form