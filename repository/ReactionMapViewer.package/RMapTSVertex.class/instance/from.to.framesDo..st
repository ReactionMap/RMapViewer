enumerating
from: vertex1 to: vertex2 framesDo: aBlock
	((edges contains: [ :edge | (edge oppositeOf: self) == vertex1 ])
		and: [ edges contains: [ :edge | (edge oppositeOf: self) == vertex2 ] ])
		ifTrue: [ 
			vertex1 label <= vertex2 label
				ifTrue: [ self multiframes do: aBlock ]
				ifFalse: [ self multiframes reverseDo: aBlock ] ]
		ifFalse: [ aBlock value: (RMapXYZFrame fromGeometry: self geometry) ]