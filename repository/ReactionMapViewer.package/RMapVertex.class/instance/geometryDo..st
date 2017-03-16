enumerating
geometryDo: aBlock
	(json at: 'geometry') do: [ :axyz | aBlock valueWithArguments: axyz ]