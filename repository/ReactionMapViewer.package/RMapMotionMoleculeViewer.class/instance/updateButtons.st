updating
updateButtons
	motionMolecule ifNil: [ ^ self ].
	jumpToStartButton
		labelGraphic:
			(moleculeIndex <= 1
				ifTrue: [ self emptyIcon ]
				ifFalse: [ self jumpToStartIcon ]).
	jumpToEndButton
		labelGraphic:
			(moleculeIndex >= motionMolecule size
				ifTrue: [ self emptyIcon ]
				ifFalse: [ self jumpToEndIcon ]).
	prevCaptionButton label: (self prevCaption ifNil: [ '' ]).
	nextCaptionButton label: (self nextCaption ifNil: [ '' ]).
	playPauseButton
		labelGraphic:
			(moleculeIndex >= motionMolecule size
				ifTrue: [ self emptyIcon ]
				ifFalse: [ 
					isPlaying = true
						ifTrue: [ self pauseIcon ]
						ifFalse: [ self playIcon ] ])