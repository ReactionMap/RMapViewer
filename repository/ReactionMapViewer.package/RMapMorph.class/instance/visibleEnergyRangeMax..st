accessing
visibleEnergyRangeMax: aNumber
	visibleEnergyRange max: (energyRange max min: aNumber).
	self changed: #visibleEnergyRangeMax