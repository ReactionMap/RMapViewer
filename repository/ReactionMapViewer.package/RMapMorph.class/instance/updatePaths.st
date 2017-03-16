updating
updatePaths
	pathSelector list: Array new.
	searchProcess ifNotNil: [ searchProcess terminate ].
	searchProcess := [ 
	paths :=  self createPaths.
	pathSelector list: (paths collect: [ :path | self morphForPath: path ]).
	self changed: #paths.
	searchProcess := nil ] forkAt: Processor userBackgroundPriority