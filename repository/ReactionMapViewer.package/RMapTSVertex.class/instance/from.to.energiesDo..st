enumerating
from: vertex1 to: vertex2 energiesDo: aBlock
	((edges contains: [ :edge | (edge oppositeOf: self) == vertex1 ])
		and: [ edges contains: [ :edge | (edge oppositeOf: self) == vertex2 ] ])
		ifTrue: [ 
			vertex1 label <= vertex2 label
				ifTrue: [ self multiframeEnergies do: aBlock ]
				ifFalse: [ self multiframeEnergies reverseDo: aBlock ] ]
		ifFalse: [ aBlock value: self energy ]