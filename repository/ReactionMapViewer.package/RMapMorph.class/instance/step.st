stepping and presenter
step
	| startTime |
	startTime := Time millisecondClockValue. 
	startTime - lastTime * 0.9 > stepTime ifTrue: [ stepTime := stepTime * 4 ].
	startTime - lastTime * 0.95 < stepTime ifTrue: [ stepTime := stepTime * 2 // 3 max: 200 ].
	lastTime := startTime.
	form := nil.
	self xNumerizer step.
	self yNumerizer step.
	self zNumerizer step.
	self projector step.
	self renderer step.
	self changed