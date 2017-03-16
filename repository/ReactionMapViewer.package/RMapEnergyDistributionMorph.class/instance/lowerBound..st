accessing
lowerBound: aNumber
	rmapMorph visibleEnergyRangeMin: (rmapMorph energyRangeMin max: aNumber).
	self changed