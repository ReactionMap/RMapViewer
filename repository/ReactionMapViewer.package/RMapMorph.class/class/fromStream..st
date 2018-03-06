instance creation
fromStream: aStream
	^ self fromDictionary: (NeoJSONReader on: aStream) next