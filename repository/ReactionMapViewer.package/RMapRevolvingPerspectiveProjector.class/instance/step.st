stepping
step
	theta := theta + 0.2.
	maxTheta <= theta ifTrue: [ theta := theta % maxTheta ]