operations
togglePlay
	isPlaying = true
		ifTrue: [ self pause ]
		ifFalse: [ self play ]