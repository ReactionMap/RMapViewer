instance creation
fromXYZStream: aStream transformationBlock: aBlock
	^ Array new writeStream
		in: [ :atoms | 
			| size |
			size := aStream nextLine asInteger.
			aStream nextLine.
			size
				timesRepeat: [ 
					aStream nextLine substrings
						in: [ :quad | 
							atoms
								nextPut:
									quad first -> (aBlock value: (RMap3dPoint x: quad second asNumber y: quad third asNumber z: quad fourth asNumber)) ] ].
			self from: atoms contents ]