instance creation
fromXYZ: aString transformationBlock: aBlock
	^ self fromXYZStream: aString readStream transformationBlock: aBlock