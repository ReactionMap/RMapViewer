enumerating
from: vertex energiesDo: aBlock
	(edges contains: [ :edge | vertex == (edge oppositeOf: self) ])
		ifTrue: [ 
			(json at: 'multiframe_energies' ifAbsent: [  ])
				ifNil: [ 
					aBlock value: self energy.
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ] ]
				ifNotNil: [ :energies | energies do: aBlock ] ]
		ifFalse: [ aBlock value: self energy ]