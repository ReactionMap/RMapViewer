instance creation
fromStream: aStream
	^ self fromDictionary: (NeoJSONReader on: aStream contents readStream) next