instance creation
fromGeometry: anArrayOfQuadruple
	^ self
		from:
			(anArrayOfQuadruple collect: [ :quad | quad first -> (RMap3dPoint x: quad second y: quad third z: quad fourth) ])