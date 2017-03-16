accessing
load: aDictionary
	self initializeRMap.
	(aDictionary at: 'vertices' ifAbsent: [ #() ]) do: [ :vertex | self addVertex: (RMapVertex fromJson: vertex) ].
	(aDictionary at: 'edges' ifAbsent: [ #() ])
		do: [ :edge | self addEdgeBetween: (edge at: 'vertex1') + 1 and: (edge at: 'vertex2') + 1 ].
	self grrm: (aDictionary at: 'grrm' ifAbsent: [  ]).
	self sortVerticesByEnergy.
	self sortEdgesByEnergy.
	self changed: #rmap.
	self changed: #paths