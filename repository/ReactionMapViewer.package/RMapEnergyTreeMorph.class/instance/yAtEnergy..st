accessing
yAtEnergy: aNumber
	| min max y |
	min := rmapMorph energyRangeMin.
	max := rmapMorph energyRangeMax.
	y := (max - aNumber) * (self height - self topMargin - self bottomMargin) / (max - min) + self topMargin + self top.
	y isNaN
		ifTrue: [ y := 0 ].
	^ y