accessing
yAtEnergy: aNumber
	| min max |
	min := rmapMorph energyRangeMin.
	max := rmapMorph energyRangeMax.
	^ ( max - aNumber) * (self height - self topMargin - self bottomMargin) / ( max -  min) + self topMargin + self top