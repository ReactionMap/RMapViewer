accessing
motionMolecule: anRMapMotionMolecule
	motionMolecule := anRMapMotionMolecule.
	moleculeViewer fitToBoundingBox: anRMapMotionMolecule boundingBox.
	isPlaying := false.
	indexToT := self createIndexToT.
	self moleculeIndex: 1