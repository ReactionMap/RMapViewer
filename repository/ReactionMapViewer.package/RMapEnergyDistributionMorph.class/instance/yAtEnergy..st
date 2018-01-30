accessing
yAtEnergy: aNumber
	| y |
	y := self bottom - ((self height - 1) * (aNumber - self min) / (self max - self min)) asFloat.
	y isNaN
		ifTrue: [ y := 0 ].
	^ y