enumerating
from: vertex1 to: vertex2 energiesDo: aBlock
	((edges contains: [ :edge | vertex1 == (edge oppositeOf: self) ])
		and: [ edges contains: [ :edge | vertex2 == (edge oppositeOf: self) ] ])
		ifTrue: [ 
			(json at: 'multiframe_energies' ifAbsent: [  ])
				ifNil: [ 
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ].
					aBlock value: self energy.
					(json at: 'multiframe_xyz' ifAbsent: [ Array with: nil ]) size - 1 timesRepeat: [ aBlock value: nil ] ]
				ifNotNil: [ :energies | 
					energies do: aBlock.
					energies size - 1 to: 1 by: -1 do: [ :index | aBlock value: (energies at: index) ] ] ]
		ifFalse: [ aBlock value: self energy ]