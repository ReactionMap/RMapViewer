accessing
tip
	presentation = #stickAndBall
		ifTrue: [ ^ 0.6 ].
	presentation = #tube
		ifTrue: [ ^ 0.5 ].
	presentation = #vanDerWaals
		ifTrue: [ ^ 3.0 ].
	^ 1.0