user interface
openAnimationOnPath
	self motionMoleculeFromPath
		ifNotNil: [ :motionMolecule | 
			| profile |
			profile := (RMapEnergyProfileMorph on: motionMolecule) yourself.
			profile openInWindow bounds: (300 @ 0 extent: 700 @ 400).
			((RMapMotionMoleculeViewer on: motionMolecule)
				indexChangedAction: [ :index | profile moleculeIndex: index ];
				openInWindow) bounds: (0 @ 0 extent: 300 @ 400) ]