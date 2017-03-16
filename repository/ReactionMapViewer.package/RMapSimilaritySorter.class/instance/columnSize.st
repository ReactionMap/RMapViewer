accessing
columnSize
	^ columnSize ifNil: [ columnSize := rmap vertices size sqrt ceiling ]