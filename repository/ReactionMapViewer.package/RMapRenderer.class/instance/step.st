stepping
step
	substep := substep + 1.
	substep > 2
		ifTrue: [ 
			substep := 1.
			step := step + 1.
			step > 12
				ifTrue: [ step := 1 ] ]