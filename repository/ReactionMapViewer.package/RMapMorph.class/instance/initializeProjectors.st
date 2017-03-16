initialize-release
initializeProjectors
	projectorSelector := RMapSelector new
		add: (RMapOrthogonalProjector on: self);
		add: (RMapRevolvingOrthogonalProjector on: self);
		add: (RMapFlippedRevolvingOrthogonalProjector on: self);
		add: (RMapPerspectiveProjector on: self);
		add: (RMapRevolvingPerspectiveProjector on: self);
		yourself