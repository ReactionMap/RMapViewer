stepping and presenter
stepTime
	^ (motionMolecule at: moleculeIndex) label ifNil: [ 300 ] ifNotNil: [ 1000 ]