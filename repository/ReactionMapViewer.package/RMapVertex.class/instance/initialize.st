initialize-release
initialize
	super initialize.
	baselineEnergy := 0.0.
	edges := OrderedCollection new.
	json := Dictionary new