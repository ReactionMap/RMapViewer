utilities
handlesStream: stream
	| ref |
	ref := stream fullName asFileReference.
	(ref isFile and: [ ref basename endsWith: '.rmap' ])
		ifTrue: [ 
			(self fromStream: ref) openFullInWorld.
			^ true ].
	ref isDirectory
		ifTrue: [ 
			(self fromDirectory: ref) ifNotNil: #openFullInWorld.
			^ true ].
	^ true