accessing
z: aNumber
	^ (super z: aNumber) ifNotNil: [  :z | 1.0 - z ]