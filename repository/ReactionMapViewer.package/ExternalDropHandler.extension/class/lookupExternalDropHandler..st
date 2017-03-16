*ReactionMapViewer
lookupExternalDropHandler: stream

	| types extension serviceHandler |
	(RMapMorph handlesStream: stream) ifTrue: [ ^nil ].
	types := stream mimeTypes.

	types ifNotNil: [
		self registeredHandlers do: [:handler | 
			(handler matchesTypes: types)
				ifTrue: [^handler]]].

	extension := stream name asFileReference extension.
	self registeredHandlers do: [:handler | 
		(handler matchesExtension: extension)
				ifTrue: [^handler]].
	
	serviceHandler := self lookupServiceBasedHandler: stream.
	^serviceHandler
		ifNil: [self defaultHandler]