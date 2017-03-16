event handling
grab: anEvent
	anEvent position
		in: [ :p | 
			| energy |
			energy := self energyAt: p.
			(energy - self lowerBound) abs < (energy - self upperBound) abs
				ifTrue: [ self lowerBound: energy ]
				ifFalse: [ self upperBound: energy ] ]