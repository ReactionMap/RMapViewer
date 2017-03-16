accessing
visibleEnergyRangeMin: aNumber
	visibleEnergyRange min: (energyRange min max: aNumber).
	self changed: #visibleEnergyRangeMin