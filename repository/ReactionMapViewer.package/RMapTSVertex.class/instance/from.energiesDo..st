enumerating
from: vertex energiesDo: aBlock
	(edges detect: [ :edge | (edge oppositeOf: self) == vertex ] ifNone: [  ])
		ifNil: [ aBlock value: self energy ]
		ifNotNil: [ :edge1 | 
			(edges detect: [ :edge | edge ~~ edge1 ] ifNone: [  ])
				ifNil: [ aBlock value: self energy ]
				ifNotNil: [ :edge2 | 
					(edge2 oppositeOf: self)
						ifNil: [ aBlock value: self energy ]
						ifNotNil: [ :vertex2 | 
							| energies |
							energies := self multiframeEnergies.
							(vertex label <= vertex2 label
								ifTrue: [ 1 to: (self multiframeIndex + 1 min: energies size) ]
								ifFalse: [ energies size to: self multiframeIndex + 1 by: -1 ]) do: [ :index | aBlock value: (energies at: index) ] ] ] ]