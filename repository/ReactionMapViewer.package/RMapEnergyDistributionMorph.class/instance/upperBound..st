accessing
upperBound: aNumber
	rmapMorph visibleEnergyRangeMax: (rmapMorph energyRangeMax min: aNumber).
	self changed