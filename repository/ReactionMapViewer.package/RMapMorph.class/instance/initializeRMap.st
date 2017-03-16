initialize-release
initializeRMap
	energyRange := RMapInterval empty.
	visibleEnergyRange := RMapInterval empty.
	vertices := OrderedCollection new.
	edges := OrderedCollection new.
	selectedVertices := Array new.
	reactants := Array new.
	products := Array new.
	viewScale := 0.9.
	viewOffset := 0.5 @ 0.5.
	hops := 1.
	paths := Array new