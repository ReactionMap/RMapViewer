utilities
handlesStream: stream
	| entry |
	entry := stream directoryEntry.
	(entry isFile and: [ stream name endsWith: '.rmap' ])
		ifTrue: [ 
			(self fromStream: stream) openFullInWorld.
			^ true ].
	entry isDirectory
		ifTrue: [ 
			(self fromDirectory: stream name asFileReference) ifNotNil: #openFullInWorld.
			^ true ].
	^ true