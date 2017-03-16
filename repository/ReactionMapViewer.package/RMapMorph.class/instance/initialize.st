initialize-release
initialize
	super initialize.
	stepTime := 500.
	lastTime := Time millisecondClockValue.
	dependents := Array new.
	self initializeRMap.
	pathSelector := RMapSelector new.
	pathSelector getMenuBlock: [ :aMenu | self addPathListMenu: aMenu ].
	pathSelector index: 0.
	maxNumberOfHops := self defaultMaxNumberOfHops.
	maxNumberOfPaths := self defaultMaxNumberOfPaths.
	pathSorter := self defaultPathSorter.
	shortestOnly := true.
	self initializeNumerizers.
	self initializeProjectors.
	self initializeRenderers