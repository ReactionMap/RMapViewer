updating
play
	playPauseButton labelGraphic: self pauseIcon.
	isPlaying := true.
	self isStepping
		ifFalse: [ self startStepping ]