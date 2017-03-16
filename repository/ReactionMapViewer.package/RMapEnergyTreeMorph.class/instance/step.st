stepping and presenter
step
	(self owner bounds containsPoint: ActiveHand position)
		ifTrue: [ self changed ]