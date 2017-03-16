private
motionMoleculeFromPath
	| triple motionMolecule e0 |
	triple := self xyzAnimationAndLabelDictionaryAndEnergyCurveFromPath.
	triple ifNil: [ ^ nil ].
	motionMolecule := RMapMotionMolecule fromXYZ: triple first.
	motionMolecule autoBonds.
	e0 := triple third ifEmpty: [ 0.0 ] ifNotEmpty: [ :nums | nums first ].
	1 to: motionMolecule size do: [ :index | 
		(motionMolecule at: index)
			label: nil;
			energy: (triple third at: index ifAbsent: [ e0 ]) - e0 ].
	triple second keysAndValuesDo: [ :index :caption | (motionMolecule at: index) label: caption ].
	^ motionMolecule