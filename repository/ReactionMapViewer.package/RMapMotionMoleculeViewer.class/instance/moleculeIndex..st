accessing
moleculeIndex: anInteger
	moleculeIndex := anInteger.
	(moleculeIndex between: 1 and: motionMolecule size)
		ifTrue: [ moleculeViewer molecule: (motionMolecule at: anInteger) ].
	self updateButtons.
	indexChangedAction ifNotNil: [ indexChangedAction cull: anInteger ].
	self changed: #moleculeIndex.
	self changed