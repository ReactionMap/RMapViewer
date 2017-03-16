stepping
step
	steps := steps + 1.
	steps > maxSteps
		ifTrue: [ rmap perform: setter with: to ]