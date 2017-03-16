searching
search
	| energy result |
	reactants ifEmpty: [ ^ Array new ].
	products ifEmpty: [ ^ Array new ].
	energy := self thresholdEnergy.
	rmap progress: 0.25.
	Processor yield.
	energy ifNil: [ ^ Array new ].
	result := self allShortestPathsWith: (self edgesWithin: energy).
	rmap progress: 1.0.
	^ result