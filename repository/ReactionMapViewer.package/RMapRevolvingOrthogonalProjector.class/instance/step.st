stepping
step
	theta := theta + 0.3.
	maxTheta <= theta ifTrue: [ theta := theta % maxTheta ]