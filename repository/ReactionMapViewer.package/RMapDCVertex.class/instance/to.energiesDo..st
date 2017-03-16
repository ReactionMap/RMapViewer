enumerating
to: vertex energiesDo: aBlock
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_energies' ifAbsent: [  ])
				ifNil: [ 
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ].
					aBlock value: self energy ]
				ifNotNil: [ :energies | energies reverseDo: aBlock ] ]
		ifFalse: [ aBlock value: self energy ]