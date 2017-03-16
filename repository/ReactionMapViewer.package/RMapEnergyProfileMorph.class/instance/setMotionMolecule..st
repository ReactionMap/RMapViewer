private
setMotionMolecule: anRMapMotionMolecule
	| lastIndex |
	motionMolecule := anRMapMotionMolecule.
	indexToTime := Array new: anRMapMotionMolecule size.
	anRMapMotionMolecule size > 0
		ifTrue: [ 
			indexToTime at: 1 put: 0.0.
			lastIndex := 1.
			1 to: anRMapMotionMolecule size do: [ :index | 
				(anRMapMotionMolecule at: index) label
					ifNotNil: [ 
						lastIndex + 1 to: index do: [ :i | indexToTime at: i put: (i - lastIndex) asFloat / (index - lastIndex) asFloat + (indexToTime at: lastIndex) ].
						lastIndex := index ] ] ].
	moleculeIndex := 1