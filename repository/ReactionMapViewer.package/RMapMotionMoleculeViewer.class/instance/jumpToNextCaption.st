operations
jumpToNextCaption
	| index |
	index := moleculeIndex.
	[ 
	index := index + 1.
	index <= motionMolecule size ]
		whileTrue: [ (motionMolecule at: index) label ifNotNil: [ ^ self moleculeIndex: index ] ].
	^ nil