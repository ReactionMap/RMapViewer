accessing
prevCaption
	| index |
	index := moleculeIndex.
	[ 
	index := index - 1.
	index >= 1 ] whileTrue: [ (motionMolecule at: index) label ifNotNil: [ :caption | ^ caption ] ].
	^ nil