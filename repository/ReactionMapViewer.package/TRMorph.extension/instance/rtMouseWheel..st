*ReactionMapViewer
rtMouseWheel: evt
	evt direction = Character arrowDown
		ifTrue: [ 
			trachelCanvas camera scale: trachelCanvas camera scale / 0.9.
			self changed ].
	evt direction = Character arrowUp
		ifTrue: [ 
			trachelCanvas camera scale: trachelCanvas camera scale * 0.9.
			self changed ].
	trachelCanvas
		announce:
			(TRMouseWheelEvent
				fromDirection: evt direction
				position: (trachelCanvas camera fromPixelToSpace: (self relativePositionFor: evt)))