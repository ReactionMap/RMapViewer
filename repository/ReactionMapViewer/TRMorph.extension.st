Extension { #name : #TRMorph }

{ #category : #'*ReactionMapViewer' }
TRMorph >> rtKeyStroke: evt [
	| relativePosition ev shape |
	(evt commandKeyPressed and: [ evt keyCharacter = $w ])
		ifTrue: [ self owner delete ].
	(evt commandKeyPressed and: [ evt keyCharacter = $p ])
		ifTrue: [ RTPDFExporter interactiveExportCanvas: trachelCanvas ].
	evt keyCharacter = Character arrowUp
		ifTrue: [ 
			trachelCanvas camera scale: trachelCanvas camera scale / 0.9.
			self changed ].
	evt keyCharacter = Character arrowDown
		ifTrue: [ 
			trachelCanvas camera scale: trachelCanvas camera scale * 0.9.
			self changed ].
	relativePosition := self relativePositionFor: evt.
	ev := TRKeyDown new
		keyValue: evt keyValue;
		keyCombination: evt asKeyCombination;
		yourself.
	shape := self shapeWithAction: TRKeyDown forPositionInPixels: relativePosition.
	ev shape: shape.
	ev morph: self.
	ev canvas: trachelCanvas.
	ev position: (trachelCanvas camera fromPixelToSpace: relativePosition).
	shape announce: ev
]

{ #category : #'*ReactionMapViewer' }
TRMorph >> rtMouseWheel: evt [
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
]
