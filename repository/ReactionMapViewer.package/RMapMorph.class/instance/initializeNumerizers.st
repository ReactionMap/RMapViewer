initialize-release
initializeNumerizers
	| sorter |
	sorter := RMapSimilaritySorter on: self.
	xNumerizerSelector := RMapNumerizerSelector new
		add: (RMapX on: self setter: #xNumerizer:);
		add: (RMapEnergy on: self setter: #xNumerizer:);
		add: (RMapKind on: self setter: #xNumerizer:);
		add: (RMapMinEnergyGapFromReactants on: self setter: #xNumerizer:);
		add: (RMapHopsFromReactants on: self setter: #xNumerizer:);
		add: (sorter xNumerizer: #xNumerizer:);
		yourself.
	yNumerizerSelector := RMapNumerizerSelector new
		add: (RMapY on: self setter: #yNumerizer:);
		add: (RMapEnergy on: self setter: #yNumerizer:);
		add: (RMapKind on: self setter: #yNumerizer:);
		add: (RMapMinEnergyGapFromReactants on: self setter: #yNumerizer:);
		add: (RMapHopsFromReactants on: self setter: #yNumerizer:);
		add: (sorter yNumerizer: #yNumerizer:);
		yourself.
	zNumerizerSelector := RMapNumerizerSelector new
		add: (RMapEnergy on: self setter: #zNumerizer:);
		add: (RMapKind on: self setter: #zNumerizer:);
		add: (RMapMinEnergyGapFromReactants on: self setter: #zNumerizer:);
		add: (RMapHopsFromReactants on: self setter: #zNumerizer:);
		yourself