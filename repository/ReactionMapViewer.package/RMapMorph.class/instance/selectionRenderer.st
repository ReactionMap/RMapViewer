accessing-renderer
selectionRenderer
	^ selectionRenderer ifNil: [ self renderer ]