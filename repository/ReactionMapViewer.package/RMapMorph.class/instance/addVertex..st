adding
addVertex: anRMapVertex
	energyRange merge: anRMapVertex energy.
	visibleEnergyRange merge: anRMapVertex energy.
	^ vertices add: anRMapVertex